-- mod_room_policy.lua
--
-- Per-room policy enforcement layered on top of the jitsi-keycloak-adapter's
-- permissions.json. Two responsibilities:
--   1. requireAuthentication: reject muc-occupant-pre-join when the session
--      carries no verified JWT (session.auth_token and
--      session.jitsi_meet_context_user both nil).
--   2. useLobby=false: tear down the auto-started lobby after mod_lobby_autostart
--      has created it (we hook muc-room-created at negative priority).
--
-- Fails OPEN on missing/malformed permissions.json — this module is
-- defense-in-depth behind the adapter's OIDC redirect, never the sole gate.

local jid = require "util.jid";
local json = require "util.json";
local st = require "util.stanza";
local timer = require "util.timer";

local POLICY_FILE = os.getenv("ROOM_POLICY_FILE")
    or module:get_option_string("room_policy_file");
local RELOAD_INTERVAL = tonumber(
    os.getenv("ROOM_POLICY_RELOAD_SEC")
    or module:get_option_string("room_policy_reload_sec")
    or "60");
local LOBBY_HOST = "lobby." .. (os.getenv("XMPP_DOMAIN") or "meet.jitsi");

local policies = {};

local function load_policies()
    if not POLICY_FILE then
        module:log("warn", "ROOM_POLICY_FILE unset; mod_room_policy is a no-op");
        policies = {};
        return;
    end
    local fh, ferr = io.open(POLICY_FILE, "r");
    if not fh then
        module:log("error", "cannot open %s: %s — fail-open", POLICY_FILE, tostring(ferr));
        policies = {};
        return;
    end
    local raw = fh:read("*a");
    fh:close();
    local list, perr = json.decode(raw);
    if type(list) ~= "table" then
        module:log("error", "permissions.json malformed (%s) — fail-open", tostring(perr));
        policies = {};
        return;
    end
    local new = {};
    local count = 0;
    for _, entry in ipairs(list) do
        if type(entry) == "table" and type(entry.room) == "string" then
            new[entry.room:lower()] = entry;
            count = count + 1;
        end
    end
    policies = new;
    module:log("info", "loaded %d room policy entries from %s", count, POLICY_FILE);
end

local function policy_for(room_jid)
    local node = jid.split(room_jid);
    if not node then return nil; end
    return policies[node:lower()];
end

-- Reject unauthenticated joins to requireAuthentication rooms.
module:hook("muc-occupant-pre-join", function(event)
    local p = policy_for(event.room.jid);
    if not (p and p.requireAuthentication) then return; end
    local session = event.origin;
    if session and (session.auth_token or session.jitsi_meet_context_user) then
        return;
    end
    module:log("info", "reject unauth join to %s from %s",
        event.room.jid, tostring(event.stanza.attr.from));
    event.origin.send(st.error_reply(event.stanza, "auth", "not-authorized",
        "Authentication required for this room"));
    return true;
end, 10);

-- Tear down lobby for useLobby=false rooms, after mod_lobby_autostart has run.
module:hook("muc-room-created", function(event)
    local room = event.room;
    local p = policy_for(room.jid);
    if not p or p.useLobby ~= false then return; end
    local lobby_jid = room._data and room._data.lobbyroom;
    if lobby_jid then
        local lobby_host = prosody.hosts[LOBBY_HOST];
        if lobby_host and lobby_host.modules.muc then
            local lobby = lobby_host.modules.muc.get_room_from_jid(lobby_jid);
            if lobby then lobby:destroy(); end
        end
        room._data.lobbyroom = nil;
    end
    if room.set_members_only then room:set_members_only(false); end
    module:log("info", "policy: lobby disabled for %s", room.jid);
end, -10);

load_policies();
if RELOAD_INTERVAL > 0 then
    timer.add_task(RELOAD_INTERVAL, function()
        load_policies();
        return RELOAD_INTERVAL;
    end);
end

module:log("info", "mod_room_policy loaded (file=%s, reload=%ds)",
    tostring(POLICY_FILE), RELOAD_INTERVAL);
