local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local PLACE_ID = game.PlaceId

local HOP_INTERVAL = 15
local hopping = false

local function serverHop()
    if hopping then
        return
    end

    hopping = true
    print("Ищем другой сервер...")

    local success, err = pcall(function()
        TeleportService:Teleport(PLACE_ID, player)
    end)

    if not success then
        warn("Ошибка перехода:", err)
        hopping = false
    end
end

while true do
    task.wait(HOP_INTERVAL)
    serverHop()
end
