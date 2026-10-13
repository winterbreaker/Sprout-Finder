local Players = game:GetService("Players")
local player = Players.LocalPlayer

local running = false

local gui = Instance.new("ScreenGui")
gui.Name = "SproutFinderUI"
gui.ResetOnSpawn = false

pcall(function()
    gui.Parent = game:GetService("CoreGui")
end)

if not gui.Parent then
    gui.Parent = player:WaitForChild("PlayerGui")
end

local frame = Instance.new("Frame")
frame.Size = UDim2.fromOffset(220, 115)
frame.Position = UDim2.new(0.5, -110, 0.2, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 36)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = gui

Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 35)
title.BackgroundTransparency = 1
title.Text = "🍯 Sprout Finder"
title.TextColor3 = Color3.fromRGB(255, 200, 70)
title.TextSize = 18
title.Font = Enum.Font.GothamBold
title.Parent = frame

local button = Instance.new("TextButton")
button.Size = UDim2.new(1, -24, 0, 42)
button.Position = UDim2.fromOffset(12, 45)
button.BackgroundColor3 = Color3.fromRGB(50, 170, 90)
button.Text = "▶ START"
button.TextColor3 = Color3.new(1, 1, 1)
button.TextSize = 16
button.Font = Enum.Font.GothamBold
button.Parent = frame

Instance.new("UICorner", button).CornerRadius = UDim.new(0, 8)

local function findSprouts()
    local found = {}

    for _, obj in ipairs(workspace:GetDescendants()) do
        if string.find(string.lower(obj.Name), "sprout", 1, true) then
            table.insert(found, obj)
        end
    end

    return found
end

button.MouseButton1Click:Connect(function()
    running = not running

    if running then
        button.Text = "■ STOP"
        button.BackgroundColor3 = Color3.fromRGB(200, 65, 65)

        task.spawn(function()
            while running do
                local ok, sprouts = pcall(findSprouts)

                if ok and #sprouts > 0 then
                    print("Найдены объекты Sprout:", #sprouts)

                    for _, obj in ipairs(sprouts) do
                        print(obj:GetFullName())
                    end
                end

                task.wait(10)
            end
        end)
    else
        button.Text = "▶ START"
        button.BackgroundColor3 = Color3.fromRGB(50, 170, 90)
    end
end)
