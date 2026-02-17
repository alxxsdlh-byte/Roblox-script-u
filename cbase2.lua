-- Script completo: GUI con botón para teletransportar a workspace.Warehouse1:GetChildren()[26]
-- Compatible con Xeno y la mayoría de executors
-- Código largo y comentado para que se entienda todo

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Crear la ScreenGui principal
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "CbaseTeleportGUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Frame principal (ventana)
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 280, 0, 160)
mainFrame.Position = UDim2.new(0.5, -140, 0.5, -80)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

-- Esquinas redondeadas del frame principal
local uiCornerMain = Instance.new("UICorner")
uiCornerMain.CornerRadius = UDim.new(0, 14)
uiCornerMain.Parent = mainFrame

-- Borde con glow suave
local uiStrokeMain = Instance.new("UIStroke")
uiStrokeMain.Color = Color3.fromRGB(80, 140, 255)
uiStrokeMain.Thickness = 2.5
uiStrokeMain.Transparency = 0.45
uiStrokeMain.Parent = mainFrame

-- Título en la parte superior
local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "Title"
titleLabel.Size = UDim2.new(1, 0, 0, 45)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Teleport a Cbase"
titleLabel.TextColor3 = Color3.fromRGB(220, 220, 255)
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 32
titleLabel.TextStrokeTransparency = 0.8
titleLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
titleLabel.Parent = mainFrame

-- Botón principal "Cbase"
local teleportButton = Instance.new("TextButton")
teleportButton.Name = "TeleportButton"
teleportButton.Size = UDim2.new(0.88, 0, 0, 70)
teleportButton.Position = UDim2.new(0.06, 0, 0.38, 0)
teleportButton.BackgroundColor3 = Color3.fromRGB(60, 140, 255)
teleportButton.BorderSizePixel = 0
teleportButton.Text = "Cbase"
teleportButton.TextColor3 = Color3.new(1, 1, 1)
teleportButton.Font = Enum.Font.GothamBold
teleportButton.TextSize = 38
teleportButton.Parent = mainFrame

local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(0, 12)
buttonCorner.Parent = teleportButton

local buttonStroke = Instance.new("UIStroke")
buttonStroke.Color = Color3.fromRGB(120, 200, 255)
buttonStroke.Thickness = 2.2
buttonStroke.Transparency = 0.3
buttonStroke.Parent = teleportButton

-- Botón cerrar (X)
local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Size = UDim2.new(0, 36, 0, 36)
closeButton.Position = UDim2.new(1, -42, 0, 6)
closeButton.BackgroundColor3 = Color3.fromRGB(220, 60, 60)
closeButton.BorderSizePixel = 0
closeButton.Text = "X"
closeButton.TextColor3 = Color3.new(1, 1, 1)
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 26
closeButton.Parent = mainFrame

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 10)
closeCorner.Parent = closeButton

-- Función que hace el teletransporte
local function teleportToTarget()
    local character = player.Character
    if not character then return end
    
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return end
    
    local warehouse1 = workspace:FindFirstChild("Warehouse1")
    if not warehouse1 then
        warn("No se encontró workspace.Warehouse1")
        return
    end
    
    local children = warehouse1:GetChildren()
    if #children < 26 then
        warn("Warehouse1 tiene menos de 26 hijos. Índice 26 no existe.")
        return
    end
    
    local target = children[26]
    if not target then
        warn("El elemento 26 no existe o fue borrado.")
        return
    end
    
    -- Teleport (4 studs arriba para no atascarse)
    humanoidRootPart.CFrame = target.CFrame + Vector3.new(0, 4, 0)
    print("Teletransportado a Warehouse1:GetChildren()[26] → Cbase")
end

-- Conectar el botón al teletransporte
teleportButton.MouseButton1Click:Connect(teleportToTarget)

-- Cerrar la GUI al presionar X
closeButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

-- Sistema de arrastrar (draggable) - versión estable y sin bugs
local dragging = false
local dragInput = nil
local dragStart = nil
local startPos = nil

local function updateDrag(input)
    local delta = input.Position - dragStart
    frame.Position = UDim2.new(
        startPos.X.Scale,
        startPos.X.Offset + delta.X,
        startPos.Y.Scale,
        startPos.Y.Offset + delta.Y
    )
end

frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = frame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

frame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UIS.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        updateDrag(input)
    end
end)

-- Animación suave de entrada (opcional pero queda bonito)
frame.Position = UDim2.new(0.5, -140, 1.5, 0)
TweenService:Create(frame, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, -140, 0.5, -80)}):Play()

print("GUI cargada → Botón 'Cbase' te teletransporta a Warehouse1:GetChildren()[26]")