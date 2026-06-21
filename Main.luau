local HttpService = game:GetService("HttpService")

local function load(url)
    local success, err = pcall(function()
        local code = game:HttpGet(url, true)
        local fn, loadErr = loadstring(code)
        if fn then
            fn()
        else
            warn("Syntax Fehler: " .. tostring(loadErr))
        end
    end)
    if not success then
        warn("Fehler: " .. url .. " - " .. tostring(err))
    end
end

local base = "https://raw.githubusercontent.com/Opopue/CHackV1/main/"

load(base .. "Shared.luau")
task.wait(0.1)
load(base .. "Toggle.luau")
task.wait(0.1)
load(base .. "Movement.luau")
task.wait(0.1)
load(base .. "Player.luau")
task.wait(0.1)
load(base .. "Camera.luau")
task.wait(0.1)
load(base .. "ESP.luau")
task.wait(0.1)
load(base .. "UI.luau")
task.wait(0.1)

print("CHack loaded! RShift to open.")
