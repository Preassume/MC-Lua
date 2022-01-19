canMine = {
    ["minecraft:acacia_log"] = "log",
    ["minecraft:acacia_leaves"] = "leaf",
}

-- Will dig forward if there's a wood log
function forward()
    local isBlock, data = turtle.inspect()
    
    if not isBlock then
        return false
    end
    
    if canMine[data.name] == "leaf" then
        turtle.dig()
        return false
    end
    
    if canMine[data.name] == "log" then
        airCounter = 0
        turtle.dig()
        turtle.forward()
        return true
    end
    return false
end

-- Similar to the forward() function, but vertical.
-- Also uses airCounter to impose a limit on how high it can go,
-- since it's allowed to go up even if there's no wood.
function up()
    local isBlock, data = turtle.inspectUp()
    
    if airCounter >= 1 then
        if canMine[data.name] == "leaf" then
            turtle.digUp()
        end
        airCounter = 0
        return false
    end
    
    if not isBlock then
        airCounter = airCounter + 1
        turtle.up()
        return true
    end
    
    if canMine[data.name] then
        if canMine[data.name] == "leaf" then
            airCounter = airCounter + 1
        else
            airCounter = 0
        end
        turtle.digUp()
        turtle.up()
        return true
    end
    
    return false
end

local acacia = {}

-- Algorithm to break every log block of an acacia tree
function acacia.mineTree()
    for i=1, 4, 1 do
        if forward() then
            acacia.mineTree()
            turtle.back()
        end
        turtle.turnRight()
    end
    if up() then
        acacia.mineTree()
        turtle.down()
    end
end

return acacia