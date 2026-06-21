local function load(url)
    local success, err = pcall(function()
        loadstring(game:HttpGet(url, true))()
    end)
    if not success then
        warn("Fehler: " .. url .. " - " .. tostring(err))
    end
end

local base = "https://raw.githubusercontent.com/Opopue/CHackV1/main/"

load(base .. "Shared.luau")
load(base .. "Toggle.luau")
load(base .. "Movement.luau")
load(base .. "Player.luau")
load(base .. "Camera.luau")
load(base .. "ESP.luau")
load(base .. "UI.luau")

print("CHack loaded! RShift to open.")
