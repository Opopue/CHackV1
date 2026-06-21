local function load(url)
    local success, result = pcall(function()
        return loadstring(game:HttpGet(url, true))()
    end)
    if not success then
        warn("Fehler beim Laden: " .. url .. " - " .. tostring(result))
    end
end

local base = "https://raw.githubusercontent.com/Opopue/CHackV1/main/"

load(base .. "Shared.luau")
load(base .. "Toggle.luau")
load(base .. "UI.luau")
load(base .. "ESP.luau")
load(base .. "Movement.luau")
load(base .. "Player.luau")
load(base .. "Camera.luau")
