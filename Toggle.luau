local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local state = _G.state

local function toggle(key)
    state[key] = not state[key]
    if _G.badges[key] and _G.strokes[key] then
        _G.setOn(_G.badges[key], _G.strokes[key], state[key])
    end
    if key == "fly" then
        if state.fly then _G.startFly() else _G.stopFly() end
    elseif key == "freecam" then
        if state.freecam then _G.startFreecam() else _G.stopFreecam() end
    elseif key == "invisible" then
        _G.setInvisible(state.invisible)
    elseif key == "fps" then
        if _G.fpsLabel then _G.fpsLabel.Visible = state.fps end
    elseif key == "god" then
        local char = game:GetService("Players").LocalPlayer.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then
                hum.MaxHealth = state.god and math.huge or 100
                hum.Health = hum.MaxHealth
            end
        end
    elseif key == "antiafk" and state.antiafk then
        local vrs = game:GetService("VirtualUser")
        game:GetService("Players").LocalPlayer.Idled:Connect(function()
            vrs:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
            task.wait(0.1)
            vrs:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
        end)
    end
end
_G.toggle = toggle

UIS.InputBegan:Connect(function(input, gp)
    if input.KeyCode == Enum.KeyCode.RightShift then
        if _G.panel then _G.panel.Visible = not _G.panel.Visible end
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

RunService.RenderStepped:Connect(function()
    local now = tick()
    local delta = now - _G.lastTime
    _G.lastTime = now
    if state.fps and delta > 0 and _G.fpsLabel then
        _G.fpsLabel.Text = "FPS: " .. math.floor(1 / delta)
    end
end)
