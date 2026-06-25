-- Combined ESP, Anti-Ban & Aimbot
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- Anti-Ban
local mt = getrawmetatable(game)
local old = mt.__namecall
setreadonly(mt, false)
mt.__namecall = newcclosure(function(self, ...)
    local args = {...}
    if getnamecallmethod() == "FireServer" and tostring(args[1]) == "Report" then return end
    return old(self, ...)
end)
setreadonly(mt, true)

-- ESP & Aimbot Loop
RunService.RenderStepped:Connect(function()
    local closestTarget = nil
    local shortestDist = math.huge
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            -- ESP
            if not player.Character:FindFirstChild("EnemyHighlight") then
                local hl = Instance.new("Highlight", player.Character)
                hl.Name = "EnemyHighlight"
                hl.FillColor = Color3.fromRGB(255, 0, 0)
                hl.FillTransparency = 0.5
                hl.AlwaysOnTop = true
            end
            
            -- Aimbot Target Search
            local head = player.Character:FindFirstChild("Head")
            if head then
                local pos, onScreen = Camera:WorldToViewportPoint(head.Position)
                local dist = (Vector2.new(pos.X, pos.Y) - Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)).Magnitude
                if onScreen and dist < shortestDist then
                    shortestDist = dist
                    closestTarget = head
                end
            end
        end
    end
    
    -- Aimbot Lock (Hold Right Click)
    if closestTarget and game:GetService("UserInputService"):IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
        Camera.CFrame = CFrame.new(Camera.CFrame.Position, closestTarget.Position)
    end
end)
