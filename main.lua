```lua
local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")

local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "VIPServerManager"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.fromOffset(320, 200)
frame.Position = UDim2.new(0.5, -160, 0.25, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 36)
frame.Parent = gui

Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 35)
title.BackgroundTransparency = 1
title.Text = "VIP Server Manager"
title.TextColor3 = Color3.fromRGB(255, 200, 70)
title.TextSize = 18
title.Font = Enum.Font.GothamBold
title.Parent = frame

local joinButton = Instance.new("TextButton")
joinButton.Size = UDim2.new(1, -24, 0, 35)
joinButton.Position = UDim2.fromOffset(12, 40)
joinButton.Text = "JOIN VIP"
joinButton.TextColor3 = Color3.new(1, 1, 1)
joinButton.TextSize = 14
joinButton.Font = Enum.Font.GothamBold
joinButton.BackgroundColor3 = Color3.fromRGB(50, 160, 90)
joinButton.Parent = frame

Instance.new("UICorner", joinButton).CornerRadius = UDim.new(0, 6)

local linkBox = Instance.new("TextBox")
linkBox.Size = UDim2.new(1, -24, 0, 35)
linkBox.Position = UDim2.fromOffset(12, 83)
linkBox.PlaceholderText = "Вставь ссылку VIP-сервера сюда"
linkBox.Text = ""
linkBox.ClearTextOnFocus = false
linkBox.TextSize = 12
linkBox.TextColor3 = Color3.new(1, 1, 1)
linkBox.PlaceholderColor3 = Color3.fromRGB(180, 180, 190)
linkBox.BackgroundColor3 = Color3.fromRGB(48, 48, 58)
linkBox.Parent = frame

Instance.new("UICorner", linkBox).CornerRadius = UDim.new(0, 6)

local saveButton = Instance.new("TextButton")
saveButton.Size = UDim2.new(1, -24, 0, 30)
saveButton.Position = UDim2.fromOffset(12, 125)
saveButton.Text = "SAVE LINK"
saveButton.TextColor3 = Color3.new(1, 1, 1)
saveButton.TextSize = 13
saveButton.Font = Enum.Font.GothamBold
saveButton.BackgroundColor3 = Color3.fromRGB(65, 95, 170)
saveButton.Parent = frame

Instance.new("UICorner", saveButton).CornerRadius = UDim.new(0, 6)

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, -24, 0, 25)
status.Position = UDim2.fromOffset(12, 163)
status.BackgroundTransparency = 1
status.Text = "Вставь ссылку и нажми SAVE LINK"
status.TextColor3 = Color3.fromRGB(220, 220, 220)
status.TextSize = 11
status.Parent = frame

local savedLink = ""

saveButton.MouseButton1Click:Connect(function()
    savedLink = linkBox.Text:match("^%s*(.-)%s*$")

    if savedLink == "" then
        status.Text = "Сначала вставь ссылку!"
        return
    end

    if not savedLink:find("roblox.com", 1, true) then
        savedLink = ""
        status.Text = "Это не похоже на ссылку Roblox"
        return
    end

    status.Text = "Ссылка сохранена!"
end)

joinButton.MouseButton1Click:Connect(function()
    if savedLink == "" then
        status.Text = "Сначала сохрани ссылку!"
        return
    end

    local code = savedLink:match("[?&]privateServerLinkCode=([^&]+)")

    if not code then
        status.Text = "Не найдена ссылка-код VIP-сервера"
        return
    end

    status.Text = "Пробую подключиться..."

    local ok, err = pcall(function()
        TeleportService:TeleportToPrivateServer(
            game.PlaceId,
            code,
            {player}
        )
    end)

    if not ok then
        status.Text = "Переход не удался"
        warn(err)
    end
end)
```
