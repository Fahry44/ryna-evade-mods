local player = game:GetService("Players").LocalPlayer
local crownId = "rbxassetid://10159600649"
local crownAccessory = nil

-- Load aksesoris dari ID Katalog
pcall(function()
    local objs = game:GetObjects(crownId)
    if objs and objs[1] then
        crownAccessory = objs[1]
    end
end)

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
    if not crownAccessory then return end
    if char:FindFirstChild(crownAccessory.Name) then return end -- Cek agar tidak tertumpuk
    
    local head = char:FindFirstChild("Head")
    if head then
        local clone = crownAccessory:Clone()
        local handle = clone:FindFirstChild("Handle")
        
        if handle then
            -- Atur posisi di atas kepala (Y = 0.5, sesuaikan jika kurang pas)
            handle.CFrame = head.CFrame * CFrame.new(0, 0.5, 0) 
            
            local weld = Instance.new("WeldConstraint")
            weld.Part0 = head
            weld.Part1 = handle
            weld.Parent = handle
            
            clone.Parent = char
        end
    end
end

-- Looping auto-pasang saat revive/mati
task.spawn(function()
    while task.wait(1.5) do
        for _, rig in ipairs(getEvadeRigs()) do
            pcall(applyCrown, rig)
        end
    end
end)