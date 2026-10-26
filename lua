
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

    if enabled then
        startScript()
    else
        stopScript()
    end
end)

gui.Parent = player:WaitForChild("PlayerGui")
