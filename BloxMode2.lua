-- ZEBIN HUB | ESP + AIMBOT + FOV CIRCLE
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- FOV Circle
local FOVCircle = Drawing.new("Circle")
FOVCircle.Position = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
FOVCircle.Radius = 150
FOVCircle.Color = Color3.fromRGB(255, 255, 255)
FOVCircle.Thickness = 1
FOVCircle.Filled = false
FOVCircle.Visible = true

RunService.RenderStepped:Connect(function()
    -- ESP Logic
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            if not p.Character:FindFirstChild("ESPHighlight") then
                local hl = Instance.new("Highlight", p.Character)
                hl.Name = "ESPHighlight"
                hl.FillColor = Color3.fromRGB(255, 0, 0)
                hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            end
        end
    end

    -- Aimbot Logic
    if UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
        local closest, min = nil, FOVCircle.Radius
        local center = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
        
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Head") then
                local pos, vis = Camera:WorldToViewportPoint(p.Character.Head.Position)
                if vis then
                    local dist = (Vector2.new(pos.X, pos.Y) - center).Magnitude
                    if dist < min then
                        closest = p.Character.Head
                        min = dist
                    end
                end
            end
        end
        
        if closest then
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, closest.Position)
        end
    end
end)
