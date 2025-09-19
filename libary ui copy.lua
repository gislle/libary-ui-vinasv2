-- Roblox UI Library Implementation
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Create ScreenGui for the UI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SpeedControlUI"
screenGui.Parent = playerGui
screenGui.ResetOnSpawn = false

-- Main frame
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 500, 0, 400)
mainFrame.Position = UDim2.new(0.5, -250, 0.5, -200)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

-- Corner radius
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = mainFrame

-- Title bar
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 40)
titleBar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 8)
titleCorner.Parent = titleBar

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -20, 1, 0)
title.Position = UDim2.new(0, 10, 0, 0)
title.BackgroundTransparency = 1
title.Text = "Speed Control"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = titleBar

-- Close button
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -35, 0, 5)
closeButton.BackgroundColor3 = Color3.fromRGB(220, 60, 60)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 14
closeButton.Parent = titleBar

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 15)
closeCorner.Parent = closeButton

-- Content area
local content = Instance.new("Frame")
content.Size = UDim2.new(1, -20, 1, -60)
content.Position = UDim2.new(0, 10, 0, 50)
content.BackgroundTransparency = 1
content.Parent = mainFrame

-- Section title
local sectionTitle = Instance.new("TextLabel")
sectionTitle.Size = UDim2.new(1, 0, 0, 30)
sectionTitle.BackgroundTransparency = 1
sectionTitle.Text = "Movement"
sectionTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
sectionTitle.Font = Enum.Font.GothamBold
sectionTitle.TextSize = 16
sectionTitle.TextXAlignment = Enum.TextXAlignment.Left
sectionTitle.Parent = content

-- Speed slider container
local sliderContainer = Instance.new("Frame")
sliderContainer.Size = UDim2.new(1, 0, 0, 60)
sliderContainer.Position = UDim2.new(0, 0, 0, 30)
sliderContainer.BackgroundTransparency = 1
sliderContainer.Parent = content

-- Slider label
local sliderLabel = Instance.new("TextLabel")
sliderLabel.Size = UDim2.new(1, 0, 0, 20)
sliderLabel.BackgroundTransparency = 1
sliderLabel.Text = "Walk Speed: 16"
sliderLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
sliderLabel.Font = Enum.Font.Gotham
sliderLabel.TextSize = 14
sliderLabel.TextXAlignment = Enum.TextXAlignment.Left
sliderLabel.Parent = sliderContainer

-- Slider background
local sliderBackground = Instance.new("Frame")
sliderBackground.Size = UDim2.new(1, 0, 0, 20)
sliderBackground.Position = UDim2.new(0, 0, 0, 25)
sliderBackground.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
sliderBackground.Parent = sliderContainer

local sliderBgCorner = Instance.new("UICorner")
sliderBgCorner.CornerRadius = UDim.new(0, 10)
sliderBgCorner.Parent = sliderBackground

-- Slider fill
local sliderFill = Instance.new("Frame")
sliderFill.Size = UDim2.new(0, 0, 1, 0)
sliderFill.BackgroundColor3 = Color3.fromRGB(97, 205, 187)
sliderFill.Parent = sliderBackground

local sliderFillCorner = Instance.new("UICorner")
sliderFillCorner.CornerRadius = UDim.new(0, 10)
sliderFillCorner.Parent = sliderFill

-- Slider button
local sliderButton = Instance.new("TextButton")
sliderButton.Size = UDim2.new(0, 20, 2, 0)
sliderButton.Position = UDim2.new(0, -10, -0.5, 0)
sliderButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
sliderButton.Text = ""
sliderButton.Parent = sliderFill

local sliderBtnCorner = Instance.new("UICorner")
sliderBtnCorner.CornerRadius = UDim.new(0, 10)
sliderBtnCorner.Parent = sliderButton

-- Min and max labels
local minLabel = Instance.new("TextLabel")
minLabel.Size = UDim2.new(0, 30, 0, 20)
minLabel.Position = UDim2.new(0, 0, 0, 50)
minLabel.BackgroundTransparency = 1
minLabel.Text = "16"
minLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
minLabel.Font = Enum.Font.Gotham
minLabel.TextSize = 12
minLabel.Parent = sliderContainer

local maxLabel = Instance.new("TextLabel")
maxLabel.Size = UDim2.new(0, 30, 0, 20)
maxLabel.Position = UDim2.new(1, -30, 0, 50)
maxLabel.BackgroundTransparency = 1
maxLabel.Text = "100"
maxLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
maxLabel.Font = Enum.Font.Gotham
maxLabel.TextSize = 12
maxLabel.TextXAlignment = Enum.TextXAlignment.Right
maxLabel.Parent = sliderContainer

-- Toggle UI visibility button
local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0, 120, 0, 40)
toggleButton.Position = UDim2.new(0, 20, 1, -60)
toggleButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
toggleButton.Text = "Toggle UI"
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.Font = Enum.Font.Gotham
toggleButton.TextSize = 14
toggleButton.Parent = mainFrame

local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(0, 8)
toggleCorner.Parent = toggleButton

-- Function to update walk speed
local function updateWalkSpeed(value)
    sliderLabel.Text = "Walk Speed: " .. tostring(value)
    local fillWidth = (value - 16) / (100 - 16)
    sliderFill.Size = UDim2.new(fillWidth, 0, 1, 0)
    
    local humanoid = player.Character and player.Character:FindFirstChild("Humanoid")
    if humanoid then
        humanoid.WalkSpeed = value
    end
end

-- Initialize slider
updateWalkSpeed(16)

-- Make the window draggable
local dragging = false
local dragInput, dragStart, startPos

titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

titleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if dragging and input == dragInput then
        local delta = input.Position - dragStart
        mainFrame.Position = startPos + UDim2.new(0, delta.X, 0, delta.Y)
    end
end)

-- Close button functionality
closeButton.MouseButton1Click:Connect(function()
    screenGui.Enabled = not screenGui.Enabled
end)

-- Toggle button functionality
toggleButton.MouseButton1Click:Connect(function()
    screenGui.Enabled = not screenGui.Enabled
end)

-- Slider functionality
local function updateSlider(input)
    if not input then return end
    
    local sliderAbsolutePosition = sliderBackground.AbsolutePosition
    local sliderAbsoluteSize = sliderBackground.AbsoluteSize
    
    local relativeX = (input.Position.X - sliderAbsolutePosition.X) / sliderAbsoluteSize.X
    relativeX = math.clamp(relativeX, 0, 1)
    
    local value = math.floor(16 + relativeX * (100 - 16))
    updateWalkSpeed(value)
end

sliderButton.MouseButton1Down:Connect(function()
    local connection
    connection = game:GetService("UserInputService").InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            updateSlider(input)
        end
    end)
    
    game:GetService("UserInputService").InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            connection:Disconnect()
        end
    end)
end)

sliderBackground.MouseButton1Down:Connect(function(input)
    updateSlider(input)
end)

-- Make UI visible by default
screenGui.Enabled = true

print("Speed Control UI loaded successfully!")
print("Use the slider to adjust your character's walk speed")
print("Click and drag the title bar to move the window")
print("Use the close button or toggle button to show/hide the UI")
