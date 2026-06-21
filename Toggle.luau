local state = _G.state
local UIS = _G.UIS

local function toggle(key)
    state[key] = not state[key]
    _G.setOn(_G.badges[key], _G.strokes[key], state[key])
    if key == "fly" then
        if state.fly then _G.startFly() else _G.stopFly() end
    elseif key == "freecam" then
        if state.freecam then _G.startFreecam() else _G.stopFreecam() end
    elseif key == "invisible" then
        _G.setInvisible(state.invisible)
    elseif key == "fps" then
        _G.fpsLabel.Visible = state.fps
    elseif key == "god" then
        local char = _G.LocalPlayer.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then
                hum.MaxHealth = state.god and math.huge or 100
                hum.Health = hum.MaxHealth
            end
        end
    elseif key == "antiafk" and state.antiafk then
        local vrs = game:GetService("VirtualUser")
        _G.LocalPlayer.Idled:Connect(function()
            vrs:Button2Down(Vector2.new(0, 0), _G.Camera.CFrame)
            task.wait(0.1)
            vrs:Button2Up(Vector2.new(0, 0), _G.Camera.CFrame)
        end)
    end
end
_G.toggle = toggle

UIS.InputBegan:Connect(function(input, gp)
    if input.KeyCode == Enum.KeyCode.RightShift then
        _G.panel.Visible = not _G.panel.Visible
        return
    end
    if _G.bindingKey then
        _G.keys[_G.bindingKey] = input.KeyCode
        local kb = _G.keyBtns[_G.bindingKey]
        if kb then
            kb.Text = input.KeyCode.Name
            kb.TextColor3 = Color3.fromRGB(150, 100, 220)
        end
        _G.bindingKey = nil
        return
    end
    if gp then return end
    for key, keyCode in pairs(_G.keys) do
        if input.KeyCode == keyCode and keyCode ~= Enum.KeyCode.Unknown then
            toggle(key)
        end
    end
end)

_G.RunService.RenderStepped:Connect(function()
    local now = tick()
    local delta = now - _G.lastTime
    _G.lastTime = now
    if state.fps and delta > 0 then
        _G.fpsLabel.Text = "FPS: " .. math.floor(1 / delta)
    end
end)

print("CHack loaded! RShift to open.")
