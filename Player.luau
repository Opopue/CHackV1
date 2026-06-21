local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local state = _G.state

local function setInvisible(on)
    local char = LocalPlayer.Character
    if not char then return end
    for _, p in pairs(char:GetDescendants()) do
        if p:IsA("BasePart") and p.Name ~= "HumanoidRootPart" then
            p.Transparency = on and 1 or 0
        end
        if p:IsA("Decal") then
            p.Transparency = on and 1 or 0
        end
    end
end
_G.setInvisible = setInvisible

UIS.JumpRequest:Connect(function()
    if state.infjump and LocalPlayer.Character then
        LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

RunService.RenderStepped:Connect(function()
    if state.invisible then setInvisible(true) end
end)
