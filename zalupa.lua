local Players = cloneref(game:GetService('Players'))
local RS = cloneref(game:GetService('RunService'))
local UIS = game:GetService('UserInputService')
local Client = Players.LocalPlayer

local size = 30
local showVisuals = true
local draggingSlider = false
local draggingMenu = false
local dragStart, startPos

local ScreenGui = Instance.new('ScreenGui')
ScreenGui.Name = 'HitboxUltraMobile'
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = Client:WaitForChild('PlayerGui')

local MainFrame = Instance.new('Frame')
MainFrame.Size = UDim2.new(0, 250, 0, 280)
MainFrame.Position = UDim2.new(0.5, -125, 0.1, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new('UICorner')
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

local OpenBtn = Instance.new("TextButton")
OpenBtn.Size = UDim2.new(0, 40, 0, 40)
OpenBtn.Position = UDim2.new(0, 10, 0.5, 0)
OpenBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
OpenBtn.Text = "H"
OpenBtn.TextColor3 = Color3.new(1,1,1)
OpenBtn.Font = Enum.Font.GothamBold
OpenBtn.Visible = false
OpenBtn.Parent = ScreenGui
Instance.new("UICorner", OpenBtn).CornerRadius = UDim.new(1, 0)

local Header = Instance.new('Frame', MainFrame)
Header.Size = UDim2.new(1, 0, 0, 35)
Header.BackgroundTransparency = 1

local Title = Instance.new('TextLabel', Header)
Title.Size = UDim2.new(1, -70, 1, 0)
Title.Position = UDim2.new(0, 12, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = 'Hitbox v2 Final'
Title.TextColor3 = Color3.new(1,1,1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left

local CloseBtn = Instance.new('TextButton', Header)
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -32, 0, 2)
CloseBtn.Text = "×"
CloseBtn.TextColor3 = Color3.new(1,0,0)
CloseBtn.BackgroundTransparency = 1
CloseBtn.TextSize = 20
CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

local MinBtn = Instance.new('TextButton', Header)
MinBtn.Size = UDim2.new(0, 30, 0, 30)
MinBtn.Position = UDim2.new(1, -62, 0, 2)
MinBtn.Text = "—"
MinBtn.TextColor3 = Color3.new(1,1,1)
MinBtn.BackgroundTransparency = 1
MinBtn.TextSize = 18
MinBtn.MouseButton1Click:Connect(function() MainFrame.Visible = false; OpenBtn.Visible = true end)
OpenBtn.MouseButton1Click:Connect(function() MainFrame.Visible = true; OpenBtn.Visible = false end)

local SizeLabel = Instance.new('TextLabel', MainFrame)
SizeLabel.Size = UDim2.new(1, 0, 0, 20)
SizeLabel.Position = UDim2.new(0, 12, 0, 45)
SizeLabel.Text = 'Size: ' .. size
SizeLabel.TextColor3 = Color3.new(0.8,0.8,0.8)
SizeLabel.BackgroundTransparency = 1
SizeLabel.Font = Enum.Font.Gotham
SizeLabel.TextXAlignment = Enum.TextXAlignment.Left

local SliderFrame = Instance.new('Frame', MainFrame)
SliderFrame.Size = UDim2.new(1, -24, 0, 25)
SliderFrame.Position = UDim2.new(0, 12, 0, 70)
SliderFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
Instance.new("UICorner", SliderFrame)

local SliderButton = Instance.new('TextButton', SliderFrame)
SliderButton.Size = UDim2.new(0, 30, 1, 0)
SliderButton.Position = UDim2.new((size - 5) / 95, 0, 0, 0)
SliderButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
SliderButton.Text = ""
Instance.new("UICorner", SliderButton)

local VisualsBtn = Instance.new('TextButton', MainFrame)
VisualsBtn.Size = UDim2.new(1, -24, 0, 35)
VisualsBtn.Position = UDim2.new(0, 12, 0, 115)
VisualsBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
VisualsBtn.Text = "Visuals: ON"
VisualsBtn.TextColor3 = Color3.new(1,1,1)
VisualsBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", VisualsBtn)

VisualsBtn.MouseButton1Click:Connect(function()
    showVisuals = not showVisuals
    VisualsBtn.Text = showVisuals and "Visuals: ON" or "Visuals: OFF"
    VisualsBtn.TextColor3 = showVisuals and Color3.new(1,1,1) or Color3.fromRGB(150, 150, 150)
end)

Header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        draggingMenu = true; dragStart = input.Position; startPos = MainFrame.Position
    end
end)

SliderButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        draggingSlider = true
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        draggingSlider = false; draggingMenu = false
    end
end)

UIS.InputChanged:Connect(function(input)
    if draggingMenu and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    elseif draggingSlider and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local inputPos = UIS:GetMouseLocation().X
        local relativeX = math.clamp(inputPos - SliderFrame.AbsolutePosition.X, 0, SliderFrame.AbsoluteSize.X)
        local percentage = relativeX / SliderFrame.AbsoluteSize.X
        size = math.floor(5 + (percentage * 95))
        SliderButton.Position = UDim2.new(percentage, -15, 0, 0)
        SizeLabel.Text = 'Size: ' .. size
    end
end)

local toggles = {
    Hitbox = true,
    GunESP = true,
    PlayerESP = true,
}

local function makeToggle(name, yPos, labelText)
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Size = UDim2.new(1, -24, 0, 30)
    btn.Position = UDim2.new(0, 12, 0, yPos)
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    btn.Text = labelText .. ": ON"
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 13
    btn.Parent = MainFrame
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

    btn.MouseButton1Click:Connect(function()  
        toggles[name] = not toggles[name]  
        btn.Text = labelText .. (toggles[name] and ": ON" or ": OFF")  
        btn.TextColor3 = toggles[name] and Color3.new(1, 1, 1) or Color3.fromRGB(150, 150, 150)  
    end)  
    return btn
end

makeToggle("Hitbox",    160, "Hitbox")
makeToggle("GunESP",    195, "Gun ESP")
makeToggle("PlayerESP", 230, "Player ESP")

local gunEspFolder = Instance.new("Folder")
gunEspFolder.Name = "GunESP"
gunEspFolder.Parent = ScreenGui

local playerEspFolder = Instance.new("Folder")
playerEspFolder.Name = "PlayerESP"
playerEspFolder.Parent = ScreenGui

local blinkState = true

task.spawn(function()
    while ScreenGui.Parent do
        blinkState = not blinkState
        if toggles.GunESP then
            for _, v in pairs(gunEspFolder:GetChildren()) do
                if v:IsA("BoxHandleAdornment") then
                    v.Transparency = blinkState and 0.3 or 1
                end
            end
        end
        task.wait(0.3)
    end
end)

local function getRole(plr)
    local char = plr.Character
    local bp = plr:FindFirstChild("Backpack")
    local hasKnife = (char and char:FindFirstChild("Knife")) or (bp and bp:FindFirstChild("Knife"))
    local hasGun = (char and char:FindFirstChild("Gun")) or (bp and bp:FindFirstChild("Gun"))
    if hasKnife then return "Murderer", Color3.fromRGB(255, 0, 0) end
    if hasGun then return "Sheriff", Color3.fromRGB(0, 150, 255) end
    return "Innocent", Color3.fromRGB(0, 255, 0)
end

RS.RenderStepped:Connect(function()
    if toggles.Hitbox then
        for _, Player in pairs(Players:GetPlayers()) do
            if Player ~= Client and Player.Character and Player.Character:FindFirstChild('HumanoidRootPart') then
                local HRP = Player.Character.HumanoidRootPart
                local Hum = Player.Character:FindFirstChild('Humanoid')
                if Hum and Hum.Health > 0 then
                    HRP.Size = Vector3.new(size, size, size)
                    HRP.CanCollide = false
                    HRP.Color = Color3.fromRGB(255, 0, 0)
                    HRP.Transparency = showVisuals and 0.6 or 1
                else
                    HRP.Size = Vector3.new(2, 2, 1)
                    HRP.Transparency = 1
                end
            end
        end
    end

    if not toggles.GunESP then  
        for _, v in pairs(gunEspFolder:GetChildren()) do v:Destroy() end  
    else  
        local gun = workspace:FindFirstChild("GunDrop")  
        if gun and gun:IsA("Model") then  
            local part = gun.PrimaryPart or gun:FindFirstChildWhichIsA("BasePart")  
            if part then  
                if not gunEspFolder:FindFirstChild("GunBox") then  
                    local box = Instance.new("BoxHandleAdornment")  
                    box.Name = "GunBox"  
                    box.Adornee = part  
                    box.AlwaysOnTop = true  
                    box.ZIndex = 5  
                    box.Size = part.Size  
                    box.Color3 = Color3.fromRGB(255, 255, 0)  
                    box.Transparency = 0.3  
                    box.Parent = gunEspFolder  
                end  
            end  
        else  
            for _, v in pairs(gunEspFolder:GetChildren()) do v:Destroy() end  
        end  
    end  

    if not toggles.PlayerESP then  
        for _, v in pairs(playerEspFolder:GetChildren()) do v:Destroy() end  
    else  
        for _, esp in pairs(playerEspFolder:GetChildren()) do  
            local plr = Players:FindFirstChild(esp.Name)  
            if not plr or not plr.Character or not plr.Character:FindFirstChild("Head")  
               or not plr.Character:FindFirstChild("Humanoid")  
               or plr.Character.Humanoid.Health <= 0 then  
                esp:Destroy()  
            end  
        end  

        for _, plr in pairs(Players:GetPlayers()) do  
            if plr ~= Client and plr.Character and plr.Character:FindFirstChild("Head") then  
                local role, color = getRole(plr)  
                local esp = playerEspFolder:FindFirstChild(plr.Name)  

                if not esp then  
                    esp = Instance.new("Highlight")  
                    esp.Name = plr.Name  
                    esp.Adornee = plr.Character  
                    esp.FillColor = color  
                    esp.FillTransparency = 0.5  
                    esp.OutlineColor = color  
                    esp.OutlineTransparency = 0  
                    esp.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop  
                    esp.Parent = playerEspFolder  
                else  
                    esp.FillColor = color  
                    esp.OutlineColor = color  
                end  

                local billboard = esp:FindFirstChild("RoleLabel")  
                if not billboard then  
                    billboard = Instance.new("BillboardGui")  
                    billboard.Name = "RoleLabel"  
                    billboard.Adornee = plr.Character.Head  
                    billboard.Size = UDim2.new(0, 100, 0, 20)  
                    billboard.StudsOffset = Vector3.new(0, 2, 0)  
                    billboard.AlwaysOnTop = true  
                    billboard.Parent = esp  

                    local label = Instance.new("TextLabel")  
                    label.Name = "Label"  
                    label.Size = UDim2.new(1, 0, 1, 0)  
                    label.BackgroundTransparency = 1  
                    label.Font = Enum.Font.GothamBold  
                    label.TextSize = 14  
                    label.TextStrokeTransparency = 0  
                    label.Parent = billboard  
                end  
                local label = billboard:FindFirstChild("Label")  
                if label then  
                    label.Text = role  
                    label.TextColor3 = color  
                end  
            end  
        end  
    end
end)
