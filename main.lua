-- Sprout Finder
-- Поиск объектов Sprout в текущем мире

local function findSprouts()
    local found = {}

    for _, obj in ipairs(workspace:GetDescendants()) do
        if string.find(string.lower(obj.Name), "sprout", 1, true) then
            table.insert(found, obj)
            print("Sprout найден:", obj:GetFullName())
        end
    end

    print("Всего найдено объектов:", #found)
    return found
end

findSprouts()
