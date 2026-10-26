
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local TARGET = 50
local SEARCH_DELAY = 0.2
local enabled = false
local collected = 0
local currentTarget = nil

local gui = Instance.new("ScreenGui")
gui.Name = "DAKAR"
gui.ResetOnSpawn = false

local button = Instance.new("TextButton")
button.Name = "Toggle"
button.Size = UDim2.new(0, 165, 0, 48)
button.Position = UDim2.new(0, 20, 0.5, 0)
button.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.TextSize = 17
button.Font = Enum.Font.GothamBold
button.Text = "DAKAR: OFF"
button.Parent = gui

local function isCandy(obj)
    local name = obj.Name:lower()

    return obj:IsA("BasePart")
        and obj.CanTouch
        and (
            name:find("candy")
            or name:find("sweet")
            or name:find("dulce")
        )
end

local function findCandy()
    local character = player.Character
    local root = character
        and character:FindFirstChild("HumanoidRootPart")

    if not root then
        return nil
    end

    local closest = nil
    local shortest = math.huge

    for _, obj in ipairs(workspace:GetDescendants()) do
        if isCandy(obj) then
            local distance =
                (obj.Position - root.Position).Magnitude

            if distance < shortest then
                shortest = distance
                closest = obj
            end
        end
    end

    return closest
end

local function updateButton()
    if enabled then
        button.Text = "DAKAR: ON"
        button.BackgroundColor3 =
            Color3.fromRGB(30, 100, 55)
    else
        button.Text = "DAKAR: OFF"
        button.BackgroundColor3 =
            Color3.fromRGB(25, 25, 25)
    end
end

local function startScript()
    task.spawn(function()
        while enabled do
            if collected >= TARGET then
                enabled = false
                updateButton()
                break
            end

            local character = player.Character
            local humanoid = character
                and character:FindFirstChildOfClass("Humanoid")
            local root = character
                and character:FindFirstChild("HumanoidRootPart")

            if humanoid and root then
                if not currentTarget
                    or not currentTarget.Parent then

                    currentTarget = findCandy()

                    if currentTarget then
                        humanoid:MoveTo(currentTarget.Position)
                    end
                elseif currentTarget.Parent then
                    humanoid:MoveTo(currentTarget.Position)

                    if (root.Position -
                        currentTarget.Position).Magnitude < 4 then
                        currentTarget = nil
                    end
                end
            end

            task.wait(SEARCH_DELAY)
        end
    end)
end

local function stopScript()
    currentTarget = nil
end

button.Activated:Connect(function()
    enabled = not enabled
    updateButton()

    if enabled then
        startScript()
    else
        stopScript()
    end
end)

player.CharacterAdded:Connect(function()
    currentTarget = nil
end)

gui.Parent = player:WaitForChild("PlayerGui")
