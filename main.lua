local player = game:GetService("Players").LocalPlayer
local rs = game:GetService("RunService")

local crown = Instance.new("Part")
crown.Size = Vector3.new(1, 1, 1)
crown.CanCollide = false
crown.Anchored = true 
crown.Parent = workspace

local mesh = Instance.new("SpecialMesh")
mesh.MeshId = "rbxassetid://10138606900"
mesh.TextureId = "rbxassetid://10138606949"
mesh.Parent = crown

local function getHead()
    local r = workspace:FindFirstChild("Rigs")
    if r and r:FindFirstChild(player.Name) then return r[player.Name]:FindFirstChild("Head") end
    
    local c = workspace:FindFirstChild("PlayerCache")
    if c and c:FindFirstChild(player.Name) and c[player.Name]:FindFirstChild("R6") then 
        return c[player.Name].R6:FindFirstChild("Head") 
    end
    
    if player.Character then return player.Character:FindFirstChild("Head") end
    return nil
end

rs.RenderStepped:Connect(function()
    local head = getHead()
    if head then
        crown.CFrame = head.CFrame * CFrame.new(0, 0.6, 0)
    else
        crown.CFrame = CFrame.new(0, 9999, 0)
    end
end)