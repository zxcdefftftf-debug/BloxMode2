-- BloxStrike Pro Hub | Anti-Ban System
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 450, 0, 350); Main.Position = UDim2.new(0.5, -225, 0.5, -175)
Main.BackgroundColor3 = Color3.fromRGB(20, 20, 20); Main.BorderSizePixel = 0

local Title = Instance.new("TextLabel", Main)
Title.Text = "BloxStrike | ZEBIN HUB"; Title.Size = UDim2.new(1, 0, 0, 50)
Title.TextColor3 = Color3.fromRGB(255, 255, 255); Title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

-- Anti-Ban (Hooking basic checks)
local mt = getrawmetatable(game)
local old = mt.__namecall
setreadonly(mt, false)
mt.__namecall = newcclosure(function(self, ...)
    local args = {...}
    if getnamecallmethod() == "FireServer" and args[1] == "Report" then return end
    return old(self, ...)
end)
setreadonly(mt, true)

-- Functions
local function CreateButton(name, callback)
    local btn = Instance.new("TextButton", Main)
    btn.Size = UDim2.new(0, 400, 0, 40); btn.Position = UDim2.new(0, 25, 0, 60 + (#Main:GetChildren() * 50))
    btn.Text = name; btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    btn.MouseButton1Click:Connect(callback)
end

CreateButton("ESP (Box + Tracer)", function()
    -- ESP Logic
end)

CreateButton("Silent Aim (FOV 100)", function()
    -- Aim Logic
end)

local ToggleBtn = Instance.new("TextButton", ScreenGui); ToggleBtn.Size = UDim2.new(0, 60, 0, 60)
ToggleBtn.Position = UDim2.new(0, 10, 0, 10); ToggleBtn.Text = "Z"; ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
ToggleBtn.MouseButton1Click:Connect(function() Main.Visible = not Main.Visible end)
