local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local crownMeshId = "rbxassetid://10138606900"
local crownTextureId = "rbxassetid://10138606949"

local crownEnabled = true

-- Buat objek mahkota independen di Camera agar tidak terhapus Evade
local crownPart = Instance.new("Part")
crownPart.Name = "8BitCrownLarp"
crownPart.Size = Vector3.new(1, 1, 1)
crownPart.CanCollide = false
crownPart.Anchored = true
crownPart.Massless = true
crownPart.Transparency = 1
crownPart.Parent = workspace.CurrentCamera

local specialMesh = Instance.new("SpecialMesh")
specialMesh.MeshId = crownMeshId
specialMesh.TextureId = crownTextureId
specialMesh.Scale = Vector3.new(1.1, 1.1, 1.1)
specialMesh.Parent = crownPart

-- Fungsi untuk mencari lokasi kepala karaktermu di Evade
local function getHead()
    local r = workspace:FindFirstChild("Rigs")
    if r and r:FindFirstChild(LocalPlayer.Name) then 
        return r[LocalPlayer.Name]:FindFirstChild("Head") 
    end
    
    local c = workspace:FindFirstChild("PlayerCache")
    if c and c:FindFirstChild(LocalPlayer.Name) and c[LocalPlayer.Name]:FindFirstChild("R6") then 
        return c[LocalPlayer.Name].R6:FindFirstChild("Head") 
    end
    
    if LocalPlayer.Character then 
        return LocalPlayer.Character:FindFirstChild("Head") 
    end
    
    return nil
end

-- Update posisi mahkota setiap frame (RenderStepped) agar terus ikut kepala
RunService.RenderStepped:Connect(function()
    if crownEnabled then
        local head = getHead()
        if head then
            crownPart.Transparency = 0
            -- Offset 0.7 agar mahkota berada pas di atas kepala (bukan menimpa)
            crownPart.CFrame = head.CFrame * CFrame.new(0, 0.7, 0)
        else
            crownPart.Transparency = 1
        end
    else
        crownPart.Transparency = 1
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