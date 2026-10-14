```lua
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "VIPServerManager"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.fromOffset(320, 190)
frame.Position = UDim2.new(0.5, -160, 0.3, 0)
frame.BackgroundColor3 = Color3.fromRGB(28, 29, 36)
frame.BorderSizePixel = 0
frame.Parent = gui

Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 38)
title.BackgroundTransparency = 1
title.Text = "VIP SERVER MANAGER"
title.TextColor3 = Color3.fromRGB(255, 195, 65)
title.Font = Enum.Font.GothamBold
title.TextSize = 17
title.Parent = frame

local join = Instance.new("TextButton")
join.Size = UDim2.new(1, -24, 0, 38)
join.Position = UDim2.fromOffset(12, 43)
join.BackgroundColor3 = Color3.fromRGB(48, 155, 91)
join.Text = "JOIN VIP"
join.TextColor3 = Color3.new(1, 1, 1)
join.Font = Enum.Font.GothamBold
join.TextSize = 14
join.Parent = frame

Instance.new("UICorner", join).CornerRadius = UDim.new(0, 7)

local linkBox = Instance.new("TextBox")
linkBox.Size = UDim2.new(1, -24, 0, 36)
linkBox.Position = UDim2.fromOffset(12, 90)
linkBox.BackgroundColor3 = Color3.fromRGB(46, 47, 57)
linkBox.PlaceholderText = "Paste VIP server link here"
linkBox.Text = ""
linkBox.TextColor3 = Color3.new(1, 1, 1)
linkBox.PlaceholderColor3 = Color3.fromRGB(175, 175, 185)
linkBox.Font = Enum.Font.Gotham
linkBox.TextSize = 12
linkBox.ClearTextOnFocus = false
linkBox.Parent = frame

Instance.new("UICorner", linkBox).CornerRadius = UDim.new(0, 7)

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, -24, 0, 25)
status.Position = UDim2.fromOffset(12, 137)
status.BackgroundTransparency = 1
status.Text = "Paste your VIP link above"
status.TextColor3 = Color3.fromRGB(205, 205, 215)
status.Font = Enum.Font.Gotham
status.TextSize = 11
status.Parent = frame

local close = Instance.new("TextButton")
close.Size = UDim2.fromOffset(25, 25)
close.Position = UDim2.new(1, -29, 0, 6)
close.BackgroundTransparency = 1
close.Text = "X"
close.TextColor3 = Color3.fromRGB(220, 220, 220)
close.TextSize = 14
close.Parent = frame

close.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

join.MouseButton1Click:Connect(function()
    local link = linkBox.Text:match("^%s*(.-)%s*$")

    if link == "" then
        status.Text = "Paste a VIP link first!"
        return
    end

    status.Text = "Open the link using Roblox"
    if link:match("^https?://www?%.?roblox%.com/") then
        status.Text = "Link entered. Teleport is not supported here."
    else
        status.Text = "Please check your Roblox link"
    end
end)
```
