local Players = game:GetService("Players")

local player = Players.LocalPlayer
local enabled = false

local gui = Instance.new("ScreenGui")
gui.Name = "DAKAR"
gui.ResetOnSpawn = false

local button = Instance.new("TextButton")
button.Name = "Toggle"
button.Size = UDim2.new(0, 140, 0, 45)
button.Position = UDim2.new(0, 20, 0.5, 0)
button.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.TextSize = 18
button.Font = Enum.Font.GothamBold
button.Text = "DAKAR: OFF"
button.Parent = gui

local function isCandy(obj)
    local name = obj.Name:lower()
    return name:find("candy")
        or name:find("sweet")
        or name:find("dulce")
end

local function startScript()
    print("DAKAR activado")
end

local function stopScript()
    print("DAKAR desactivado")
end

button.Activated:Connect(function()
    enabled = not enabled

    button.Text = enabled and "DAKAR: ON" or "DAKAR: OFF"
    button.BackgroundColor3 = enabled
        and Color3.fromRGB(30, 100, 55)
        or Color3.fromRGB(25, 25, 25)
        
local target = nil

local function findCandy()
    local character = player.Character
    local root = character and character:FindFirstChild("HumanoidRootPart")
    if not root then return nil end

    local closest = nil
    local distance = math.huge

    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and obj.CanTouch then
            local name = obj.Name:lower()

            if name:find("candy")
                or name:find("sweet")
                or name:find("dulce") then

                local d = (obj.Position - root.Position).Magnitude
                if d < distance then
                    distance = d
                    closest = obj
                end
            end
        end
    end

    return closest
end

local function startScript()
    task.spawn(function()
        while enabled do
            local character = player.Character
            local humanoid = character
                and character:FindFirstChildOfClass("Humanoid")

            target = findCandy()

            if humanoid and target then
                humanoid:MoveTo(target.Position)
            end

            task.wait(1)
        end
    end)
end

local function stopScript()
    local character = player.Character
    local humanoid = character
        and character:FindFirstChildOfClass("Humanoid")

    if humanoid then
        humanoid:MoveTo(
            character:FindFirstChild("HumanoidRootPart").Position
        )
    end
        end

gui.Parent = player:WaitForChild("PlayerGui")
