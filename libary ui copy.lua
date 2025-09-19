-- Crona UI Library
local Crona = {}
local UserInputService = game:GetService("UserInputService")

-- Colors - Purple and black theme
Crona.AccentColor = Color3.fromRGB(147, 112, 219)  -- Purple
Crona.BackgroundColor = Color3.fromRGB(20, 20, 20) -- Black
Crona.SectionColor = Color3.fromRGB(30, 30, 30)    -- Dark gray
Crona.TextColor = Color3.fromRGB(255, 255, 255)    -- White
Crona.SubTextColor = Color3.fromRGB(200, 200, 200) -- Light gray

-- Create a new library instance
function Crona:New(config)
    config = config or {}
    local lib = {
        Name = config.Name or "Crona UI",
        Size = config.Size or Vector2.new(500, 400),
        Tabs = {},
        CurrentTab = nil,
        Visible = true
    }
    
    -- Create the main UI
    lib.ScreenGui = Instance.new("ScreenGui")
    lib.ScreenGui.Name = "CronaUI"
    lib.ScreenGui.ResetOnSpawn = false
    lib.ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    lib.ScreenGui.Parent = game:GetService("CoreGui") or game.Players.LocalPlayer:WaitForChild("PlayerGui")

    -- Main frame
    lib.MainFrame = Instance.new("Frame")
    lib.MainFrame.Size = UDim2.new(0, lib.Size.X, 0, lib.Size.Y)
    lib.MainFrame.Position = UDim2.new(0.5, -lib.Size.X/2, 0.5, -lib.Size.Y/2)
    lib.MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    lib.MainFrame.BackgroundColor3 = Crona.BackgroundColor
    lib.MainFrame.BorderSizePixel = 0
    lib.MainFrame.Parent = lib.ScreenGui

    -- Corner radius
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = lib.MainFrame

    -- Title bar
    lib.TitleBar = Instance.new("Frame")
    lib.TitleBar.Size = UDim2.new(1, 0, 0, 40)
    lib.TitleBar.BackgroundColor3 = Crona.SectionColor
    lib.TitleBar.BorderSizePixel = 0
    lib.TitleBar.Parent = lib.MainFrame

    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 8)
    titleCorner.Parent = lib.TitleBar

    lib.Title = Instance.new("TextLabel")
    lib.Title.Size = UDim2.new(1, -100, 1, 0)
    lib.Title.Position = UDim2.new(0, 10, 0, 0)
    lib.Title.BackgroundTransparency = 1
    lib.Title.Text = lib.Name
    lib.Title.TextColor3 = Crona.AccentColor
    lib.Title.Font = Enum.Font.GothamBold
    lib.Title.TextSize = 18
    lib.Title.TextXAlignment = Enum.TextXAlignment.Left
    lib.Title.Parent = lib.TitleBar

    -- Close button
    lib.CloseButton = Instance.new("TextButton")
    lib.CloseButton.Size = UDim2.new(0, 30, 0, 30)
    lib.CloseButton.Position = UDim2.new(1, -35, 0, 5)
    lib.CloseButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    lib.CloseButton.TextColor3 = Crona.TextColor
    lib.CloseButton.Font = Enum.Font.GothamBold
    lib.CloseButton.TextSize = 16
    lib.CloseButton.Text = "X"
    lib.CloseButton.Parent = lib.TitleBar

    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 6)
    closeCorner.Parent = lib.CloseButton

    -- Hide button (SIMPLE)
    lib.HideButton = Instance.new("TextButton")
    lib.HideButton.Size = UDim2.new(0, 30, 0, 30)
    lib.HideButton.Position = UDim2.new(1, -70, 0, 5)
    lib.HideButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    lib.HideButton.TextColor3 = Crona.TextColor
    lib.HideButton.Font = Enum.Font.GothamBold
    lib.HideButton.TextSize = 16
    lib.HideButton.Text = "_"
    lib.HideButton.Parent = lib.TitleBar

    local hideCorner = Instance.new("UICorner")
    hideCorner.CornerRadius = UDim.new(0, 6)
    hideCorner.Parent = lib.HideButton

    -- Tabs container
    lib.TabsContainer = Instance.new("Frame")
    lib.TabsContainer.Size = UDim2.new(1, -20, 0, 30)
    lib.TabsContainer.Position = UDim2.new(0, 10, 0, 45)
    lib.TabsContainer.BackgroundTransparency = 1
    lib.TabsContainer.Parent = lib.MainFrame

    -- Content area
    lib.Content = Instance.new("Frame")
    lib.Content.Size = UDim2.new(1, -20, 1, -85)
    lib.Content.Position = UDim2.new(0, 10, 0, 80)
    lib.Content.BackgroundTransparency = 1
    lib.Content.Parent = lib.MainFrame

    -- Make the window draggable
    local dragging = false
    local dragInput, dragStart, startPos

    lib.TitleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = lib.MainFrame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    lib.TitleBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and input == dragInput then
            local delta = input.Position - dragStart
            lib.MainFrame.Position = startPos + UDim2.new(0, delta.X, 0, delta.Y)
        end
    end)

    -- Close button functionality
    lib.CloseButton.MouseButton1Click:Connect(function()
        lib.ScreenGui:Destroy()
    end)

    -- Hide button functionality (SIMPLE)
    lib.HideButton.MouseButton1Click:Connect(function()
        lib.MainFrame.Visible = not lib.MainFrame.Visible
    end)

    -- Toggle UI function
    function lib:Toggle()
        lib.MainFrame.Visible = not lib.MainFrame.Visible
    end

    -- Add tab function
    function lib:AddTab(name)
        local tab = {
            Name = name,
            Buttons = {},
            Sections = {}
        }
        
        -- Create tab button
        tab.Button = Instance.new("TextButton")
        tab.Button.Size = UDim2.new(0, 80, 1, 0)
        tab.Button.Position = UDim2.new(0, (#lib.Tabs * 85), 0, 0)
        tab.Button.BackgroundColor3 = Crona.SectionColor
        tab.Button.Text = name
        tab.Button.TextColor3 = Crona.SubTextColor
        tab.Button.Font = Enum.Font.Gotham
        tab.Button.TextSize = 14
        tab.Button.Parent = lib.TabsContainer
        
        local tabCorner = Instance.new("UICorner")
        tabCorner.CornerRadius = UDim.new(0, 6)
        tabCorner.Parent = tab.Button
        
        -- Create tab content
        tab.Container = Instance.new("ScrollingFrame")
        tab.Container.Size = UDim2.new(1, 0, 1, 0)
        tab.Container.Position = UDim2.new(0, 0, 0, 0)
        tab.Container.BackgroundTransparency = 1
        tab.Container.BorderSizePixel = 0
        tab.Container.ScrollBarThickness = 4
        tab.Container.ScrollBarImageColor3 = Crona.AccentColor
        tab.Container.Visible = false
        tab.Container.Parent = lib.Content
        
        -- Tab click event
        tab.Button.MouseButton1Click:Connect(function()
            lib:SelectTab(tab)
        end)
        
        table.insert(lib.Tabs, tab)
        
        -- Select first tab by default
        if #lib.Tabs == 1 then
            lib:SelectTab(tab)
        end
        
        -- Add section function for this tab
        function tab:AddSection(config)
            config = config or {}
            local section = {
                Name = config.Name or "Section",
                Buttons = {},
                Toggles = {},
                Sliders = {}
            }
            
            -- Section container
            section.Container = Instance.new("Frame")
            section.Container.Size = UDim2.new(1, -10, 0, 40)
            section.Container.Position = UDim2.new(0, 5, 0, (#tab.Sections * 45) + 5)
            section.Container.BackgroundColor3 = Crona.SectionColor
            section.Container.Parent = tab.Container
            
            local sectionCorner = Instance.new("UICorner")
            sectionCorner.CornerRadius = UDim.new(0, 6)
            sectionCorner.Parent = section.Container
            
            -- Section title
            section.Title = Instance.new("TextLabel")
            section.Title.Size = UDim2.new(1, -10, 0, 20)
            section.Title.Position = UDim2.new(0, 10, 0, 10)
            section.Title.BackgroundTransparency = 1
            section.Title.Text = section.Name
            section.Title.TextColor3 = Crona.TextColor
            section.Title.Font = Enum.Font.GothamBold
            section.Title.TextSize = 16
            section.Title.TextXAlignment = Enum.TextXAlignment.Left
            section.Title.Parent = section.Container
            
            -- Elements container
            section.Elements = Instance.new("Frame")
            section.Elements.Size = UDim2.new(1, -10, 0, 0)
            section.Elements.Position = UDim2.new(0, 5, 0, 30)
            section.Elements.BackgroundTransparency = 1
            section.Elements.Parent = section.Container
            
            -- Add button function for this section
            function section:AddButton(config)
                config = config or {}
                local button = {
                    Name = config.Name or "Button",
                    Callback = config.Callback or function() end
                }
                
                button.Frame = Instance.new("Frame")
                button.Frame.Size = UDim2.new(1, 0, 0, 30)
                button.Frame.Position = UDim2.new(0, 0, 0, (#section.Buttons * 35))
                button.Frame.BackgroundTransparency = 1
                button.Frame.Parent = section.Elements
                
                button.Button = Instance.new("TextButton")
                button.Button.Size = UDim2.new(1, 0, 0, 30)
                button.Button.BackgroundColor3 = Crona.AccentColor
                button.Button.Text = button.Name
                button.Button.TextColor3 = Crona.TextColor
                button.Button.Font = Enum.Font.Gotham
                button.Button.TextSize = 14
                button.Button.Parent = button.Frame
                
                local buttonCorner = Instance.new("UICorner")
                buttonCorner.CornerRadius = UDim.new(0, 6)
                buttonCorner.Parent = button.Button
                
                -- Button click event
                button.Button.MouseButton1Click:Connect(function()
                    button.Callback()
                end)
                
                -- Update section height
                section.Container.Size = UDim2.new(1, -10, 0, 40 + (#section.Buttons * 35) + 5)
                
                table.insert(section.Buttons, button)
                return button
            end
            
            -- Add toggle function for this section
            function section:AddToggle(config)
                config = config or {}
                local toggle = {
                    Name = config.Name or "Toggle",
                    Default = config.Default or false,
                    Callback = config.Callback or function() end
                }
                
                toggle.Frame = Instance.new("Frame")
                toggle.Frame.Size = UDim2.new(1, 0, 0, 30)
                toggle.Frame.Position = UDim2.new(0, 0, 0, (#section.Toggles * 35))
                toggle.Frame.BackgroundTransparency = 1
                toggle.Frame.Parent = section.Elements
                
                toggle.Label = Instance.new("TextLabel")
                toggle.Label.Size = UDim2.new(0.7, 0, 1, 0)
                toggle.Label.BackgroundTransparency = 1
                toggle.Label.Text = toggle.Name
                toggle.Label.TextColor3 = Crona.TextColor
                toggle.Label.Font = Enum.Font.Gotham
                toggle.Label.TextSize = 14
                toggle.Label.TextXAlignment = Enum.TextXAlignment.Left
                toggle.Label.Parent = toggle.Frame
                
                toggle.Button = Instance.new("TextButton")
                toggle.Button.Size = UDim2.new(0, 50, 0, 25)
                toggle.Button.Position = UDim2.new(1, -55, 0.5, -12.5)
                toggle.Button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                toggle.Button.Text = ""
                toggle.Button.Parent = toggle.Frame
                
                local toggleCorner = Instance.new("UICorner")
                toggleCorner.CornerRadius = UDim.new(0, 12)
                toggleCorner.Parent = toggle.Button
                
                toggle.Slider = Instance.new("Frame")
                toggle.Slider.Size = UDim2.new(0, 20, 0, 20)
                toggle.Slider.Position = UDim2.new(0, 3, 0.5, -10)
                toggle.Slider.BackgroundColor3 = Crona.TextColor
                toggle.Slider.Parent = toggle.Button
                
                local sliderCorner = Instance.new("UICorner")
                sliderCorner.CornerRadius = UDim.new(0, 10)
                sliderCorner.Parent = toggle.Slider
                
                -- Set initial state
                local function updateToggle(state)
                    if state then
                        toggle.Slider.Position = UDim2.new(0, 27, 0.5, -10)
                        toggle.Button.BackgroundColor3 = Crona.AccentColor
                    else
                        toggle.Slider.Position = UDim2.new(0, 3, 0.5, -10)
                        toggle.Button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                    end
                    toggle.Callback(state)
                end
                
                updateToggle(toggle.Default)
                
                -- Toggle click event
                toggle.Button.MouseButton1Click:Connect(function()
                    toggle.Default = not toggle.Default
                    updateToggle(toggle.Default)
                end)
                
                -- Update section height
                section.Container.Size = UDim2.new(1, -10, 0, 40 + (#section.Toggles * 35) + 5)
                
                table.insert(section.Toggles, toggle)
                return toggle
            end
            
            -- Add slider function (NO BUTTON - SIMPLE)
            function section:AddSlider(config)
                config = config or {}
                local slider = {
                    Name = config.Name or "Slider",
                    Min = config.Min or 0,
                    Max = config.Max or 100,
                    Default = config.Default or 50,
                    Callback = config.Callback or function() end,
                    Precision = config.Precision or 1
                }
                
                slider.Frame = Instance.new("Frame")
                slider.Frame.Size = UDim2.new(1, 0, 0, 50)
                slider.Frame.Position = UDim2.new(0, 0, 0, (#section.Sliders * 55))
                slider.Frame.BackgroundTransparency = 1
                slider.Frame.Parent = section.Elements
                
                slider.Label = Instance.new("TextLabel")
                slider.Label.Size = UDim2.new(1, 0, 0, 20)
                slider.Label.BackgroundTransparency = 1
                slider.Label.Text = slider.Name .. ": " .. slider.Default
                slider.Label.TextColor3 = Crona.TextColor
                slider.Label.Font = Enum.Font.Gotham
                slider.Label.TextSize = 14
                slider.Label.TextXAlignment = Enum.TextXAlignment.Left
                slider.Label.Parent = slider.Frame
                
                slider.Background = Instance.new("Frame")
                slider.Background.Size = UDim2.new(1, 0, 0, 15)
                slider.Background.Position = UDim2.new(0, 0, 0, 25)
                slider.Background.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                slider.Background.Parent = slider.Frame
                
                local bgCorner = Instance.new("UICorner")
                bgCorner.CornerRadius = UDim.new(0, 7)
                bgCorner.Parent = slider.Background
                
                slider.Fill = Instance.new("Frame")
                slider.Fill.Size = UDim2.new(0, 0, 1, 0)
                slider.Fill.BackgroundColor3 = Crona.AccentColor
                slider.Fill.Parent = slider.Background
                
                local fillCorner = Instance.new("UICorner")
                fillCorner.CornerRadius = UDim.new(0, 7)
                fillCorner.Parent = slider.Fill
                
                -- Min and max labels
                slider.MinLabel = Instance.new("TextLabel")
                slider.MinLabel.Size = UDim2.new(0, 30, 0, 20)
                slider.MinLabel.Position = UDim2.new(0, 0, 0, 40)
                slider.MinLabel.BackgroundTransparency = 1
                slider.MinLabel.Text = tostring(slider.Min)
                slider.MinLabel.TextColor3 = Crona.SubTextColor
                slider.MinLabel.Font = Enum.Font.Gotham
                slider.MinLabel.TextSize = 12
                slider.MinLabel.Parent = slider.Frame
                
                slider.MaxLabel = Instance.new("TextLabel")
                slider.MaxLabel.Size = UDim2.new(0, 30, 0, 20)
                slider.MaxLabel.Position = UDim2.new(1, -30, 0, 40)
                slider.MaxLabel.BackgroundTransparency = 1
                slider.MaxLabel.Text = tostring(slider.Max)
                slider.MaxLabel.TextColor3 = Crona.SubTextColor
                slider.MaxLabel.Font = Enum.Font.Gotham
                slider.MaxLabel.TextSize = 12
                slider.MaxLabel.TextXAlignment = Enum.TextXAlignment.Right
                slider.MaxLabel.Parent = slider.Frame
                
                -- Function to update slider
                function slider:Update(value)
                    value = math.clamp(value, slider.Min, slider.Max)
                    if slider.Precision == 1 then
                        value = math.floor(value)
                    else
                        value = math.floor(value * (1/slider.Precision)) / (1/slider.Precision)
                    end
                    slider.Label.Text = slider.Name .. ": " .. tostring(value)
                    local fillWidth = (value - slider.Min) / (slider.Max - slider.Min)
                    slider.Fill.Size = UDim2.new(fillWidth, 0, 1, 0)
                    slider.Callback(value)
                end
                
                -- Set initial value
                slider:Update(slider.Default)
                
                -- Slider functionality (click and drag on the background)
                slider.Background.MouseButton1Down:Connect(function(input)
                    local function updateSlider(input)
                        if not input then return end
                        
                        local sliderAbsolutePosition = slider.Background.AbsolutePosition
                        local sliderAbsoluteSize = slider.Background.AbsoluteSize
                        
                        local relativeX = (input.Position.X - sliderAbsolutePosition.X) / sliderAbsoluteSize.X
                        relativeX = math.clamp(relativeX, 0, 1)
                        
                        local value = slider.Min + relativeX * (slider.Max - slider.Min)
                        slider:Update(value)
                    end
                    
                    updateSlider(input)
                    
                    local connection
                    connection = UserInputService.InputChanged:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseMovement then
                            updateSlider(input)
                        end
                    end)
                    
                    UserInputService.InputEnded:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            connection:Disconnect()
                        end
                    end)
                end)
                
                -- Update section height
                section.Container.Size = UDim2.new(1, -10, 0, 40 + (#section.Sliders * 55) + 5)
                
                table.insert(section.Sliders, slider)
                return slider
            end
            
            table.insert(tab.Sections, section)
            return section
        end
        
        return tab
    end
    
    -- Select tab function
    function lib:SelectTab(tab)
        if lib.CurrentTab then
            lib.CurrentTab.Button.BackgroundColor3 = Crona.SectionColor
            lib.CurrentTab.Button.TextColor3 = Crona.SubTextColor
            lib.CurrentTab.Container.Visible = false
        end
        
        lib.CurrentTab = tab
        tab.Button.BackgroundColor3 = Crona.AccentColor
        tab.Button.TextColor3 = Crona.TextColor
        tab.Container.Visible = true
    end
    
    setmetatable(lib, self)
    self.__index = self
    return lib
end

return Crona
