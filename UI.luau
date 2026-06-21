local UIS = _G.UIS
local state = _G.state
local keys = _G.keys

local gui = Instance.new("ScreenGui", game.CoreGui)
gui.ResetOnSpawn = false
_G.gui = gui

_G.fpsLabel = Drawing.new("Text")
_G.fpsLabel.Visible = false
_G.fpsLabel.Color = Color3.fromRGB(192, 132, 252)
_G.fpsLabel.Size = 16
_G.fpsLabel.Outline = true
_G.fpsLabel.OutlineColor = Color3.fromRGB(0, 0, 0)
_G.fpsLabel.Position = Vector2.new(10, 10)

local panel = Instance.new("Frame", gui)
panel.Size = UDim2.new(0, 300, 0, 0)
panel.Position = UDim2.new(0.5, -150, 0.5, -310)
panel.BackgroundColor3 = Color3.fromRGB(13, 13, 20)
panel.BorderSizePixel = 0
panel.AutomaticSize = Enum.AutomaticSize.Y
panel.Visible = false
Instance.new("UICorner", panel).CornerRadius = UDim.new(0, 12)
local panelStroke = Instance.new("UIStroke", panel)
panelStroke.Color = Color3.fromRGB(108, 63, 197)
panelStroke.Thickness = 1
_G.panel = panel

local dragging, dragStart, startPos
panel.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = panel.Position
    end
end)
panel.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
end)
UIS.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        panel.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
    if state.freecam and _G.freecamPart and input.UserInputType == Enum.UserInputType.MouseMovement then
        _G.freecamYaw = _G.freecamYaw - input.Delta.X * 0.3
        _G.freecamPitch = math.clamp(_G.freecamPitch - input.Delta.Y * 0.3, -80, 80)
        _G.freecamPart.CFrame = CFrame.new(_G.freecamPart.CFrame.Position)
            * CFrame.Angles(0, math.rad(_G.freecamYaw), 0)
            * CFrame.Angles(math.rad(_G.freecamPitch), 0, 0)
        _G.Camera.CFrame = _G.freecamPart.CFrame
    end
end)

local layout = Instance.new("UIListLayout", panel)
layout.Padding = UDim.new(0, 0)

local header = Instance.new("Frame", panel)
header.Size = UDim2.new(1, 0, 0, 36)
header.BackgroundColor3 = Color3.fromRGB(26, 15, 46)
header.BorderSizePixel = 0
Instance.new("UICorner", header).CornerRadius = UDim.new(0, 12)
local logo = Instance.new("TextLabel", header)
logo.Size = UDim2.new(1, 0, 1, 0)
logo.Position = UDim2.new(0, 14, 0, 0)
logo.BackgroundTransparency = 1
logo.TextColor3 = Color3.fromRGB(192, 132, 252)
logo.Text = "CHack"
logo.Font = Enum.Font.GothamBold
logo.TextSize = 14
logo.TextXAlignment = Enum.TextXAlignment.Left

local function makeSection(name)
    local f = Instance.new("Frame", panel)
    f.Size = UDim2.new(1, 0, 0, 0)
    f.BackgroundTransparency = 1
    f.AutomaticSize = Enum.AutomaticSize.Y
    local l = Instance.new("UIListLayout", f)
    l.Padding = UDim.new(0, 4)
    local pad = Instance.new("UIPadding", f)
    pad.PaddingLeft = UDim.new(0, 12)
    pad.PaddingRight = UDim.new(0, 12)
    pad.PaddingTop = UDim.new(0, 8)
    pad.PaddingBottom = UDim.new(0, 6)
    local title = Instance.new("TextLabel", f)
    title.Size = UDim2.new(1, 0, 0, 16)
    title.BackgroundTransparency = 1
    title.TextColor3 = Color3.fromRGB(124, 95, 160)
    title.Text = name
    title.Font = Enum.Font.GothamBold
    title.TextSize = 10
    title.TextXAlignment = Enum.TextXAlignment.Left
    return f
end

local function setOn(badge, stroke, on)
    if on then
        badge.Text = "ON"
        badge.BackgroundColor3 = Color3.fromRGB(26, 61, 26)
        badge.TextColor3 = Color3.fromRGB(74, 222, 128)
        stroke.Color = Color3.fromRGB(74, 222, 128)
    else
        badge.Text = "OFF"
        badge.BackgroundColor3 = Color3.fromRGB(45, 16, 96)
        badge.TextColor3 = Color3.fromRGB(168, 85, 247)
        stroke.Color = Color3.fromRGB(59, 31, 110)
    end
end
_G.setOn = setOn

local function makeBtn(text, parent, stateKey)
    local row = Instance.new("Frame", parent)
    row.Size = UDim2.new(1, 0, 0, 28)
    row.BackgroundTransparency = 1
    local rowL = Instance.new("UIListLayout", row)
    rowL.FillDirection = Enum.FillDirection.Horizontal
    rowL.Padding = UDim.new(0, 4)
    local btn = Instance.new("TextButton", row)
    btn.Size = UDim2.new(1, -70, 1, 0)
    btn.BackgroundColor3 = Color3.fromRGB(26, 15, 46)
    btn.BorderSizePixel = 0
    btn.AutoButtonColor = false
    btn.Text = ""
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 7)
    local stroke = Instance.new("UIStroke", btn)
    stroke.Color = Color3.fromRGB(59, 31, 110)
    stroke.Thickness = 1
    local label = Instance.new("TextLabel", btn)
    label.Size = UDim2.new(1, -44, 1, 0)
    label.Position = UDim2.new(0, 8, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.Font = Enum.Font.Gotham
    label.TextSize = 11
    label.TextColor3 = Color3.fromRGB(192, 132, 252)
    label.TextXAlignment = Enum.TextXAlignment.Left
    local badge = Instance.new("TextLabel", btn)
    badge.Size = UDim2.new(0, 32, 0, 16)
    badge.Position = UDim2.new(1, -36, 0.5, -8)
    badge.BackgroundColor3 = Color3.fromRGB(45, 16, 96)
    badge.Text = "OFF"
    badge.Font = Enum.Font.GothamBold
    badge.TextSize = 9
    badge.TextColor3 = Color3.fromRGB(168, 85, 247)
    Instance.new("UICorner", badge).CornerRadius = UDim.new(0, 4)
    local keyBtn = Instance.new("TextButton", row)
    keyBtn.Size = UDim2.new(0, 62, 1, 0)
    keyBtn.BackgroundColor3 = Color3.fromRGB(20, 10, 35)
    keyBtn.BorderSizePixel = 0
    keyBtn.AutoButtonColor = false
    keyBtn.Text = "---"
    keyBtn.Font = Enum.Font.GothamBold
    keyBtn.TextSize = 10
    keyBtn.TextColor3 = Color3.fromRGB(150, 100, 220)
    Instance.new("UICorner", keyBtn).CornerRadius = UDim.new(0, 7)
    Instance.new("UIStroke", keyBtn).Color = Color3.fromRGB(59, 31, 110)
    keyBtn.MouseButton1Click:Connect(function()
        _G.bindingKey = stateKey
        keyBtn.Text = "..."
        keyBtn.TextColor3 = Color3.fromRGB(255,
