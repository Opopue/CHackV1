local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera
local LocalPlayer = game:GetService("Players").LocalPlayer
local state = _G.state
local freecamSpeed = 0.5

local function startFreecam()
    _G.freecamPart = Instance.new("Part", workspace)
    _G.freecamPart.Anchored = true
    _G.freecamPart.CanCollide = false
    _G.freecamPart.Transparency = 1
    _G.freecamPart.Size = Vector3.new(1, 1, 1)
    _G.freecamPart.CFrame = Camera.CFrame
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.Anchored = true
    end
    Camera.CameraType = Enum.CameraType.Scriptable
    Camera.CFrame = _G.freecamPart.CFrame
    UIS.MouseBehavior = Enum.MouseBehavior.LockCenter
end

local function stopFreecam()
    Camera.CameraType = Enum.CameraType.Custom
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.Anchored = false
    end
    if _G.freecamPart then _G.freecamPart:Destroy() _G.freecamPart = nil end
    UIS.MouseBehavior = Enum.MouseBehavior.Default
end

_G.startFreecam = startFreecam
_G.stopFreecam = stopFreecam

RunService.RenderStepped:Connect(function()
    if state.freecam and _G.freecamPart then
        local dir = Vector3.zero
        local cf = _G.freecamPart.CFrame
        if UIS:IsKeyDown(Enum.KeyCode.W) then dir = dir + cf.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.S) then dir = dir - cf.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.A) then dir = dir - cf.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.D) then dir = dir + cf.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.Space) then dir = dir + Vector3.new(0,1,0) end
        if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then dir = dir - Vector3.new(0,1,0) end
        _G.freecamPart.CFrame = _G.freecamPart.CFrame + dir * freecamSpeed
        Camera.CFrame = _G.freecamPart.CFrame
    end
end)
