local player = game:GetService("Players").LocalPlayer
local meshId = "rbxassetid://10138606900"
local textureId = "rbxassetid://10138606949"

local function getEvadeRigs()
    local rigs = {}
    if player.Character then table.insert(rigs, player.Character) end
    pcall(function()
        local r = workspace:FindFirstChild("Rigs")
        if r and r:FindFirstChild(player.Name) then table.insert(rigs, r[player.Name]) end
    end)
    return rigs
end

local function applyCrown(char)
    if char:FindFirstChild("8BitCrown") then return end
    
    local head = char:FindFirstChild("Head")
    if not head then return end

    local crown = Instance.new("Part")
    crown.Name = "8BitCrown"
    crown.Size = Vector3.new(1, 1, 1)
    crown.CanCollide = false
    crown.Massless = true
    
    local mesh = Instance.new("SpecialMesh")
    mesh.MeshId = meshId
    mesh.TextureId = textureId
    mesh.Scale = Vector3.new(1, 1, 1)
    mesh.Parent = crown
    
    -- Atur posisi (Y=0.6 untuk di atas kepala)
    crown.CFrame = head.CFrame * CFrame.new(0, 0.6, 0)
    
    local weld = Instance.new("WeldConstraint")
    weld.Part0 = head
    weld.Part1 = crown
    weld.Parent = crown
    
    crown.Parent = char
end

task.spawn(function()
    while task.wait(1.5) do
        for _, rig in ipairs(getEvadeRigs()) do
            pcall(applyCrown, rig)
        end
    end
end)