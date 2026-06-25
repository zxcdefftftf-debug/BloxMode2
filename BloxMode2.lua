-- ZEBIN HUB | ESP + AIMBOT + ANTI-KICK + AUTO-WIN
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
    if getnamecallmethod() == "FireServer" and (tostring(args[1]) == "Kick" or tostring(args[1]) == "Ban") then return nil end
    return oldNamecall(self, ...)
end)
setreadonly(mt, true)

-- GUI Setup
local ScreenGui = Instance.new("ScreenGui", CoreGui)
local MainFrame = Instance.new("Frame", ScreenGui); MainFrame.Size = UDim2.new(0, 200, 0, 250); MainFrame.Position = UDim2.new(0.5, -100, 0.5, -125); MainFrame.Visible = false; MainFrame.BackgroundColor3 = Color3.fromRGB(20,20,20)
local Input = Instance.new("TextBox", ScreenGui); Input.Size = UDim2.new(0, 200, 0, 50); Input.Position = UDim2.new(0.5, -100, 0.5, -25); Input.PlaceholderText = "Введите ключ"
local CheckBtn = Instance.new("TextButton", ScreenGui); CheckBtn.Size = UDim2.new(0, 200, 0, 50); CheckBtn.Position = UDim2.new(0.5, -100, 0.5, 35); CheckBtn.Text = "Активировать"

CheckBtn.MouseButton1Click:Connect(function()
    if Input.Text == "SERIY-290" then
        Input:Destroy(); CheckBtn:Destroy(); MainFrame.Visible = true
        
        -- Auto-Win Logic (Standard implementation for rounds)
        local function AutoWin()
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("RemoteEvent") and (v.Name == "Win" or v.Name == "Finish") then
                    v:FireServer()
                end
            end
        end

        RunService.RenderStepped:Connect(function()
            -- ESP
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character and not p.Character:FindFirstChild("ESPHighlight") then
                    local hl = Instance.new("Highlight", p.Character)
                    hl.Name = "ESPHighlight"; hl.FillColor = Color3.fromRGB(255, 0, 0)
                end
            end
            -- Aimbot
            if UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
                local closest, min = nil, 200
                for _, p in pairs(Players:GetPlayers()) do
                    if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Head") then
                        local pos, vis = Camera:WorldToViewportPoint(p.Character.Head.Position)
                        local dist = (Vector2.new(pos.X, pos.Y) - Camera.ViewportSize/2).Magnitude
                        if vis and dist < min then closest = p.Character.Head; min = dist end
                    end
                end
                if closest then Camera.CFrame = CFrame.new(Camera.CFrame.Position, closest.Position) end
            end
        end)
    end
end)
