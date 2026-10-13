local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local crownEnabled = true

-- Buat mahkota di Terrain
local crown = Instance.new("Part")
crown.Name = "8BitCrownLarp"
crown.Size = Vector3.new(1, 1, 1)
crown.CanCollide = false
crown.Anchored = true 
crown.Parent = workspace.Terrain

local mesh = Instance.new("SpecialMesh")
mesh.MeshId = "rbxassetid://10138606900"
mesh.TextureId = "rbxassetid://10138606949"
mesh.Scale = Vector3.new(1.5, 1.5, 1.5) -- Ukuran diperkecil
mesh.Parent = crown

-- Buat efek partikel api 8-bit
local fire = Instance.new("ParticleEmitter")
fire.Texture = "rbxassetid://10126369396"
fire.Rate = 15
fire.Lifetime = NumberRange.new(0.5, 1)
fire.Speed = NumberRange.new(1, 3)
fire.LightEmission = 0.8
fire.Size = NumberSequence.new(0.8, 0)
fire.Parent = crown

-- Loop posisi ngikutin kepala
RunService.RenderStepped:Connect(function()
    if not crownEnabled then
        crown.Transparency = 1
        fire.Enabled = false
        crown.CFrame = CFrame.new(0, 9999, 0)
        return
    end

    local head
    local rigs = workspace:FindFirstChild("Rigs")
    if rigs and rigs:FindFirstChild(LocalPlayer.Name) then
        head = rigs[LocalPlayer.Name]:FindFirstChild("Head")
    elseif LocalPlayer.Character then
        head = LocalPlayer.Character:FindFirstChild("Head")
    end

    if head then
        crown.Transparency = 0
        fire.Enabled = true
        crown.CFrame = head.CFrame * CFrame.new(0, 0.8, 0) -- Tinggi disesuaikan
    else
        crown.Transparency = 1
        fire.Enabled = false
        crown.CFrame = CFrame.new(0, 9999, 0)
    end
end)

-- ==========================================
-- STRUKTUR UI
-- ==========================================
pcall(function() 
    local oldUi = LocalPlayer.PlayerGui:FindFirstChild("CrownLarpUI") 
    if oldUi then oldUi:Destroy() end 
end)

local gui = Instance.new("ScreenGui")
gui.Name = "CrownLarpUI"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = LocalPlayer.PlayerGui

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 240, 0, 160)
mainFrame.Position = UDim2.new(0, 20, 0.5, -80)
mainFrame.BackgroundColor3 = Color3.fromRGB(17, 17, 19)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = gui

local corner = Instance.new("UICorner") corner.CornerRadius = UDim.new(0, 10) corner.Parent = mainFrame
local stroke = Instance.new("UIStroke") stroke.Color = Color3.fromRGB(46, 46, 54) stroke.Thickness = 1 stroke.Parent = mainFrame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -40, 0, 34)
title.Position = UDim2.new(0, 12, 0, 0)
title.BackgroundTransparency = 1
title.Text = "8-Bit Crown Larp"
title.TextColor3 = Color3.fromRGB(240, 240, 245)
title.Font = Enum.Font.GothamBold
title.TextSize = 15
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = mainFrame

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 24, 0, 24)
closeBtn.Position = UDim2.new(1, -30, 0, 6)
closeBtn.Text = "X"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 13
closeBtn.BackgroundColor3 = Color3.fromRGB(34, 34, 40)
closeBtn.TextColor3 = Color3.fromRGB(240, 240, 245)
closeBtn.Parent = mainFrame

local closeCorner = Instance.new("UICorner") closeCorner.CornerRadius = UDim.new(0, 6) closeCorner.Parent = closeBtn

local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(1, -24, 0, 40)
toggleBtn.Position = UDim2.new(0, 12, 0, 40)
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.TextSize = 14
toggleBtn.TextColor3 = Color3.fromRGB(240, 240, 245)
toggleBtn.Parent = mainFrame

local toggleCorner = Instance.new("UICorner") toggleCorner.CornerRadius = UDim.new(0, 8) toggleCorner.Parent = toggleBtn

local infoText = Instance.new("TextLabel")
infoText.Size = UDim2.new(1, -24, 0, 18)
infoText.Position = UDim2.new(0, 12, 0, 95)
infoText.BackgroundTransparency = 1
infoText.Text = "Press K to toggle UI"
infoText.TextColor3 = Color3.fromRGB(160, 162, 170)
infoText.Font = Enum.Font.Gotham
infoText.TextSize = 12
infoText.Parent = mainFrame

local infoText2 = Instance.new("TextLabel")
infoText2.Size = UDim2.new(1, -24, 0, 18)
infoText2.Position = UDim2.new(0, 12, 0, 115)
infoText2.BackgroundTransparency = 1
infoText2.Text = "Made by Fahry44"
infoText2.TextColor3 = Color3.fromRGB(160, 162, 170)
infoText2.Font = Enum.Font.Gotham
infoText2.TextSize = 12
infoText2.Parent = mainFrame

local function refreshUI()
    if crownEnabled then
        toggleBtn.Text = "Crown : ON"
        toggleBtn.BackgroundColor3 = Color3.fromRGB(22, 163, 74)
    else
        toggleBtn.Text = "Crown : OFF"
        toggleBtn.BackgroundColor3 = Color3.fromRGB(24, 24, 28)
    end
end

toggleBtn.MouseButton1Click:Connect(function()
    crownEnabled = not crownEnabled
    refreshUI()
end)

closeBtn.MouseButton1Click:Connect(function() mainFrame.Visible = false end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.K then mainFrame.Visible = not mainFrame.Visible end
end)

refreshUI()