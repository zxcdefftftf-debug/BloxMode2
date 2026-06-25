-- ESP: Visible Enemies (Chams/Highlight)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local function CreateHighlight(character)
    if character:FindFirstChild("EnemyHighlight") then return end
    
    local hl = Instance.new("Highlight", character)
    hl.Name = "EnemyHighlight"
    hl.FillColor = Color3.fromRGB(255, 0, 0) -- Красный для врагов
    hl.OutlineColor = Color3.fromRGB(255, 255, 255)
    hl.FillTransparency = 0.5
    hl.OutlineTransparency = 0
    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop -- Видно сквозь стены
end

RunService.RenderStepped:Connect(function()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            -- Добавляем проверку команд, если есть (TeamColor/Team)
            CreateHighlight(player.Character)
        end
    end
end)
