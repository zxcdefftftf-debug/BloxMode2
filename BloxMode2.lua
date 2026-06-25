-- Combined ESP & Aimbot (BloxStrike)
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- Bypass
local mt = getrawmetatable(game)
local old = mt.__namecall
setreadonly(mt, false)
mt.__namecall = newcclosure(function(self, ...)
    local args = {...}
    if getnamecallmethod() == "FireServer" and tostring(args[1]) == "Report" then return end
    return old(self, ...)
end)
setreadonly(mt, true)

-- Main Loop
RunService.RenderStepped:Connect(function()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            -- ESP
            if not p.Character:FindFirstChild("ESPHighlight") then
                local hl = Instance.new("Highlight", p.Character)
                hl.Name = "ESPHighlight"
                hl.FillColor = Color3.fromRGB(255, 0, 0)
                hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            end
            -- Aimbot (Right Click)
            if game:GetService("UserInputService"):IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
                local head = p.Character:FindFirstChild("Head")
                if head then
                    Camera.CFrame = CFrame.new(Camera.CFrame.Position, head.Position)
                end
            end
        end
    end
end)
