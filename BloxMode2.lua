-- ZEBIN HUB | Key System + ESP + Aimbot + Anti-Kick
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- Anti-Kick Hook
local mt = getrawmetatable(game)
local oldNamecall = mt.__namecall
setreadonly(mt, false)
mt.__namecall = newcclosure(function(self, ...)
    local args = {...}
    local method = getnamecallmethod()
    -- Block standard Kick/Teleport/Ban detection methods
    if method == "FireServer" and (tostring(args[1]) == "Kick" or tostring(args[1]) == "Ban") then
        return nil
    end
    return oldNamecall(self, ...)
end)
setreadonly(mt, true)

-- GUI Setup
local ScreenGui = Instance.new("ScreenGui", CoreGui)
local KeyFrame = Instance.new("Frame", ScreenGui)
KeyFrame.Size = UDim2.new(0, 300, 0, 150); KeyFrame.Position = UDim2.new(0.5, -150, 0.5, -75); KeyFrame.BackgroundColor3 = Color3.fromRGB(20,20,20)
local Input = Instance.new("TextBox", KeyFrame); Input.Size = UDim2.new(0, 260, 0, 40); Input.Position = UDim2.new(0, 20, 0, 20); Input.PlaceholderText = "Введите ключ"
local CheckBtn = Instance.new("TextButton", KeyFrame); CheckBtn.Size = UDim2.new(0, 260, 0, 40); CheckBtn.Position = UDim2.new(0, 20, 0, 80); CheckBtn.Text = "Активировать"

-- FOV Circle
local FOVCircle = Drawing.new("Circle")
FOVCircle.Position = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
FOVCircle.Radius = 150; FOVCircle.Visible = false; FOVCircle.Filled = false; FOVCircle.Color = Color3.new(1,1,1)

CheckBtn.MouseButton1Click:Connect(function()
    if Input.Text == "SERIY-290" then
        KeyFrame:Destroy()
        FOVCircle.Visible = true
        
        RunService.RenderStepped:Connect(function()
            -- ESP
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character and not p.Character:FindFirstChild("ESPHighlight") then
                    local hl = Instance.new("Highlight", p.Character)
                    hl.Name = "ESPHighlight"; hl.FillColor = Color3.fromRGB(255, 0, 0); hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                end
            end

            -- Aimbot (Head)
            if UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
                local closest, min = nil, FOVCircle.Radius
                for _, p in pairs(Players:GetPlayers()) do
                    if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Head") then
                        local pos, vis = Camera:WorldToViewportPoint(p.Character.Head.Position)
                        local dist = (Vector2.new(pos.X, pos.Y) - Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)).Magnitude
                        if vis and dist < min then closest = p.Character.Head; min = dist end
                    end
                end
                if closest then Camera.CFrame = CFrame.new(Camera.CFrame.Position, closest.Position) end
            end
        end)
    end
end)
