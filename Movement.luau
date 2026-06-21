local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera
local LocalPlayer = game:GetService("Players").LocalPlayer
local state = _G.state

local function startFly()
    local char = LocalPlayer.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end
    char.Humanoid.PlatformStand = true
    _G.bodyVel = Instance.new("BodyVelocity", root)
    _G.bodyVel.MaxForce = Vector3.new(1e5, 1e5, 1e5)
    _G.bodyVel.Velocity = Vector3.zero
    _G.bodyGyro = Instance.new("BodyGyro", root)
    _G.bodyGyro.MaxTorque = Vector3.new(1e5, 1e5, 1e5)
    _G.bodyGyro.CFrame = root.CFrame
end

local function stopFly()
    local char = LocalPlayer.Character
    if char then char.Humanoid.PlatformStand = false end
    if _G.bodyVel then _G.bodyVel:Destroy() _G.bodyVel = nil end
    if _G.bodyGyro then _G.bodyGyro:Destroy() _G.bodyGyro = nil end
end

_G.startFly = startFly
_G.stopFly = stopFly

RunService.RenderStepped:Connect(function()
    if state.fly and _G.bodyVel and _G.bodyGyro then
        local dir = Vector3.zero
        local cf = Camera.CFrame
        if UIS:IsKeyDown(Enum.KeyCode.W) then dir = dir + cf.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.S) then dir = dir - cf.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.A) then dir = dir - cf.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.D) then dir = dir + cf.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.Space) then dir = dir + Vector3.new(0,1,0) end
        if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then dir = dir - Vector3.new(0,1,0) end
        _G.bodyVel.Velocity = dir.Magnitude > 0 and dir.Unit * _G.flySpeed or Vector3.zero
        _G.bodyGyro.CFrame = cf
    end
    if LocalPlayer.Character then
        local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed = state.speed and 50 or 16 end
    end
    if state.noclip and LocalPlayer.Character then
        for _, p in pairs(LocalPlayer.Character:GetDescendants()) do
            if p:IsA("BasePart") then p.CanCollide = false end
        end
    end
end)
