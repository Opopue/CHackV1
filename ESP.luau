repeat task.wait() until Drawing ~= nil
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local state = _G.state
local espTable = _G.espTable
local RunService = game:GetService("RunService")

local function createEntry(p)
    local box = Drawing.new("Square")
    box.Visible = false
    box.Color = Color3.fromRGB(168, 85, 247)
    box.Thickness = 2
    box.Filled = false
    local tag = Drawing.new("Text")
    tag.Visible = false
    tag.Color = Color3.fromRGB(255, 255, 255)
    tag.Size = 14
    tag.Center = true
    tag.Outline = true
    tag.OutlineColor = Color3.fromRGB(0, 0, 0)
    tag.Text = p.Name
    espTable[p] = { box = box, tag = tag }
end

local function removeEntry(p)
    if espTable[p] then
        espTable[p].box:Remove()
        espTable[p].tag:Remove()
        if espTable[p].hpBg then espTable[p].hpBg:Remove() end
        if espTable[p].hpBar then espTable[p].hpBar:Remove() end
        if espTable[p].distLabel then espTable[p].distLabel:Remove() end
        espTable[p] = nil
    end
end

for _, p in pairs(Players:GetPlayers()) do
    if p ~= LocalPlayer then createEntry(p) end
end
Players.PlayerAdded:Connect(createEntry)
Players.PlayerRemoving:Connect(removeEntry)

RunService.RenderStepped:Connect(function()
    for player, data in pairs(espTable) do
        local box = data.box
        local tag = data.tag
        local char = player.Character
        if char and char:FindFirstChild("HumanoidRootPart") and char:FindFirstChild("Head") then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum and hum.Health > 0 then
                local rootPos, onScreen = Camera:WorldToViewportPoint(char.HumanoidRootPart.Position)
                if onScreen then
                    local s = 1 / rootPos.Z * 100
                    local w = s * 10
                    local h = s * 20
                    box.Size = Vector2.new(w, h)
                    box.Position = Vector2.new(rootPos.X - w/2, rootPos.Y - h/2)
                    box.Visible = state.esp
                    tag.Position = Vector2.new(rootPos.X, rootPos.Y - h/2 - 18)
                    tag.Text = player.Name
                    tag.Visible = state.nametags
                    if state.health then
                        local hpRatio = math.clamp(hum.Health / hum.MaxHealth, 0, 1)
                        if not data.hpBg then
                            local bg = Drawing.new("Square")
                            bg.Filled = true
                            bg.Color = Color3.fromRGB(0, 0, 0)
                            bg.Transparency = 0.5
                            data.hpBg = bg
                            local bar = Drawing.new("Square")
                            bar.Filled = true
                            data.hpBar = bar
                        end
                        local barH = h * hpRatio
                        local barX = rootPos.X + w/2 + 3
                        data.hpBg.Size = Vector2.new(4, h)
                        data.hpBg.Position = Vector2.new(barX, rootPos.Y - h/2)
                        data.hpBg.Visible = true
                        data.hpBar.Size = Vector2.new(4, barH)
                        data.hpBar.Position = Vector2.new(barX, rootPos.Y + h/2 - barH)
                        data.hpBar.Color = Color3.fromRGB(math.floor(255*(1-hpRatio)), math.floor(255*hpRatio), 0)
                        data.hpBar.Visible = true
                    else
                        if data.hpBg then data.hpBg.Visible = false end
                        if data.hpBar then data.hpBar.Visible = false end
                    end
                    if state.range then
                        if not data.distLabel then
                            local d = Drawing.new("Text")
                            d.Size = 12
                            d.Center = false
                            d.Outline = true
                            d.OutlineColor = Color3.fromRGB(0, 0, 0)
                            d.Color = Color3.fromRGB(220, 220, 220)
                            data.distLabel = d
                        end
                        local lchar = LocalPlayer.Character
                        local dist = 0
                        if lchar and lchar:FindFirstChild("HumanoidRootPart") then
                            dist = math.floor((char.HumanoidRootPart.Position - lchar.HumanoidRootPart.Position).Magnitude)
                        end
                        data.distLabel.Text = dist .. " studs"
                        data.distLabel.Position = Vector2.new(rootPos.X - w/2, rootPos.Y + h/2 + 3)
                        data.distLabel.Visible = true
                    else
                        if data.distLabel then data.distLabel.Visible = false end
                    end
                else
                    box.Visible = false tag.Visible = false
                    if data.hpBg then data.hpBg.Visible = false end
                    if data.hpBar then data.hpBar.Visible = false end
                    if data.distLabel then data.distLabel.Visible = false end
                end
            else
                box.Visible = false tag.Visible = false
                if data.hpBg then data.hpBg.Visible = false end
                if data.hpBar then data.hpBar.Visible = false end
                if data.distLabel then data.distLabel.Visible = false end
            end
        end
    end
end)
