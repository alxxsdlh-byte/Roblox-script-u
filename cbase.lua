-- Mi Super Farm Simple - Ejemplo para loadstring
print("¡Script cargado! Bienvenido, Alexxs 🔥")

local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")
local root = char:WaitForChild("HumanoidRootPart")

-- Super velocidad y salto
humanoid.WalkSpeed = 100
humanoid.JumpPower = 100

-- ESP básico (ver jugadores con highlight)
for _, plr in ipairs(game.Players:GetPlayers()) do
    if plr ~= player and plr.Character then
        local highlight = Instance.new("Highlight")
        highlight.FillColor = Color3.fromRGB(255, 0, 0)
        highlight.OutlineColor = Color3.fromRGB(255, 255, 0)
        highlight.FillTransparency = 0.5
        highlight.OutlineTransparency = 0
        highlight.Parent = plr.Character
    end
end

-- Mensaje chévere
local ScreenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
local TextLabel = Instance.new("TextLabel")
TextLabel.Size = UDim2.new(0, 400, 0, 50)
TextLabel.Position = UDim2.new(0.5, -200, 0.1, 0)
TextLabel.BackgroundTransparency = 0.6
TextLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
TextLabel.TextColor3 = Color3.fromRGB(0, 255, 100)
TextLabel.Font = Enum.Font.GothamBold
TextLabel.TextSize = 28
TextLabel.Text = "Super Farm Activado - Alexxs Mode 😈"
TextLabel.Parent = ScreenGui

print("ESP + Speed + Jump activados! Disfruta el farm")