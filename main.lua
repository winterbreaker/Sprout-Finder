-- My Roblox Account Manager
-- Account slots + 12-minute timer
-- LocalScript

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local TOTAL_ACCOUNTS = 300
local INTERVAL = 12 * 60

local currentAccount = 1
local running = false
local secondsLeft = INTERVAL

local gui = Instance.new("ScreenGui")
gui.Name = "MyAccountManager"
gui.ResetOnSpawn = false

local frame = Instance.new("Frame")
frame.Size = UDim2.fromOffset(320, 270)
frame.Position = UDim2.new(0, 25, 0.5, -135)
frame.BackgroundColor3 = Color3.fromRGB(30, 32, 42)
frame.BorderSizePixel = 0
frame.Parent = gui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 42)
title.BackgroundColor3 = Color3.fromRGB(48, 52, 68)
title.Text = "MY ACCOUNT MANAGER"
title.TextColor3 = Color3.new(1, 1, 1)
title.TextScaled = true
title.Parent = frame

local function makeLabel(y, height)
    local label = Instance.new("TextLabel")
    label.Position = UDim2.fromOffset(10, y)
    label.Size = UDim2.new(1, -20, 0, height)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.new(1, 1, 1)
    label.TextScaled = true
    label.Parent = frame
    return label
end

local accountLabel = makeLabel(50, 30)
local timerLabel = makeLabel(82, 25)
local statusLabel = makeLabel(108, 25)

local function updateUI()
    accountLabel.Text = string.format(
        "Account slot: %d / %d",
        currentAccount,
        TOTAL_ACCOUNTS
    )

    timerLabel.Text = string.format(
        "Next slot in: %02d:%02d",
        math.floor(secondsLeft / 60),
        secondsLeft % 60
    )

    statusLabel.Text = running and "Status: Running" or "Status: Stopped"
end

local function makeButton(text, x, y, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.fromOffset(140, 38)
    button.Position = UDim2.fromOffset(x, y)
    button.BackgroundColor3 = Color3.fromRGB(65, 90, 140)
    button.TextColor3 = Color3.new(1, 1, 1)
    button.TextScaled = true
    button.Text = text
    button.Parent = frame
    button.Activated:Connect(callback)
    return button
end

makeButton("Previous", 10, 145, function()
    currentAccount = math.max(1, currentAccount - 1)
    secondsLeft = INTERVAL
    updateUI()
end)

makeButton("Next", 170, 145, function()
    currentAccount = math.min(TOTAL_ACCOUNTS, currentAccount + 1)
    secondsLeft = INTERVAL
    updateUI()
end)

makeButton("Start", 10, 190, function()
    running = true
    updateUI()
end)

makeButton("Stop", 170, 190, function()
    running = false
    updateUI()
end)

gui.Parent = player:WaitForChild("PlayerGui")
updateUI()

task.spawn(function()
    while gui.Parent do
        task.wait(1)

        if running then
            secondsLeft -= 1

            if secondsLeft <= 0 then
                secondsLeft = INTERVAL
                currentAccount += 1

                if currentAccount > TOTAL_ACCOUNTS then
                    currentAccount = 1
                end
            end

            updateUI()
        end
    end
end)
