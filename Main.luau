local function load(url)
    return loadstring(game:HttpGet(url))()
end

local base = "https://raw.githubusercontent.com/Opopue/CHackV1/main/"

load(base .. "Shared.luau")
load(base .. "Toggle.luau")
load(base .. "UI.luau")
load(base .. "ESP.luau")
load(base .. "Movement.luau")
load(base .. "Player.luau")
load(base .. "Camera.luau")
