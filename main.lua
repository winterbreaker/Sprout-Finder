local running = true
local CHECK_INTERVAL = 10

local function findSprouts()
    local found = {}

    for _, obj in ipairs(workspace:GetDescendants()) do
        if string.find(
            string.lower(obj.Name),
            "sprout",
            1,
            true
        ) then
            table.insert(found, obj)
        end
    end

    return found
end

while running do
    local success, result = pcall(findSprouts)

    if success then
        print("Найдено ростков:", #result)
    else
        warn("Ошибка поиска:", result)
    end

    task.wait(CHECK_INTERVAL)
end
