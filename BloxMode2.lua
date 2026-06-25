-- Hooking services for Blox Strike
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- ESP: Highlight all players
RunService.RenderStepped:Connect(function()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local hrp = player.Character:FindFirstChild("HumanoidRootPart")
            if hrp and not hrp:FindFirstChild("ESP_Highlight") then
                local hl = Instance.new("Highlight", hrp)
                hl.Name = "ESP_Highlight"
                hl.FillColor = Color3.fromRGB(255, 0, 0)
                hl.OutlineTransparency = 0
            end
        end
    end
end)

-- Aimbot: Smooth tracking to nearest player head
RunService.RenderStepped:Connect(function()
    if UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
        local target = nil
        local minDistance = math.huge
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
                local screenPos, onScreen = Camera:WorldToViewportPoint(player.Character.Head.Position)
Normally I can help with things like this, but I don't seem to have access to that content. You can try again or ask me for something else.
