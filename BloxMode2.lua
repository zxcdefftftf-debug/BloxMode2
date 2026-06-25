-- ZEBIN HUB | Modular GUI
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

-- GUI Elements
local ScreenGui = Instance.new("ScreenGui", CoreGui)
local MainFrame = Instance.new("Frame", ScreenGui); MainFrame.Size = UDim2.new(0, 200, 0, 200); MainFrame.Position = UDim2.new(0.5, -100, 0.5, -100); MainFrame.Visible = false; MainFrame.BackgroundColor3 = Color3.fromRGB(30,30,30)
local Input = Instance.new("TextBox", ScreenGui); Input.Size = UDim2.new(0, 200, 0, 50); Input.Position = UDim2.new(0.5, -100, 0.5, -25); Input.PlaceholderText = "Введите ключ"
local CheckBtn = Instance.new("TextButton", ScreenGui); CheckBtn.Size = UDim2.new(0, 200, 0, 50); CheckBtn.Position = UDim2.new(0.5, -100, 0.5, 35); CheckBtn.Text = "Войти"

local Toggles = {ESP = false, Aimbot = false}

local function CreateToggle(name, y)
    local btn = Instance.new("TextButton", MainFrame); btn.Size = UDim2.new(0, 180, 0, 40); btn.Position = UDim2.new(0, 10, 0, y)
    btn.Text = name; btn.MouseButton1Click:Connect(function() Toggles[name] = not Toggles[name]; btn.BackgroundColor3 = Toggles[name] and Color3.fromRGB(0,255,0) or Color3.fromRGB(45,45,45) end)
end

CreateToggle("ESP", 10); CreateToggle("Aimbot", 60)
local WinBtn = Instance.new("TextButton", MainFrame); WinBtn.Size = UDim2.new(0, 180, 0, 40); WinBtn.Position = UDim2.new(0, 10, 0, 110); WinBtn.Text = "AUTO-WIN"
WinBtn.MouseButton1Click:Connect(function() for _,v in pairs(workspace:GetDescendants()) do if v:IsA("RemoteEvent") and (v.Name=="Win" or v.Name=="Finish") then v:FireServer() end end end)

CheckBtn.MouseButton1Click:Connect(function()
    if Input.Text == "SERIY-290" then Input:Destroy(); CheckBtn:Destroy(); MainFrame.Visible = true end
end)

RunService.RenderStepped:Connect(function()
    if Toggles.ESP then
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and not p.Character:FindFirstChild("ESPHighlight") then
                local hl = Instance.new("Highlight", p.Character); hl.Name = "ESPHighlight"; hl.FillColor = Color3.fromRGB(255,0,0)
            end
        end
    else
        for _, p in pairs(Players:GetPlayers()) do if p.Character and p.Character:FindFirstChild("ESPHighlight") then p.Character.ESPHighlight:Destroy() end end
    end
    
    if Toggles.Aimbot and UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
        local closest, min = nil, 500
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
