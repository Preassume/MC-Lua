local updatePeriod = 5
local decayPeriod = 60

local preapi = require("commonAPI")

-- The blocks we use as "home" points (right in front of sapling)
-- Edit these two to change what kind of blocks you want to use
-- to indicate home points
local nextHome = "minecraft:andesite"
local gotoFirstHome = "minecraft:polished_andesite"
local fixedHome = "minecraft:cobbled_deepslate"

local sapling = "minecraft:acacia_sapling"

local rightCounter = 0
local airCounter = 0
local treeCounter = 0
local logTotal = 0

-- Define a list of usable home blocks and define their type
local isHome = {
    [nextHome] = "next",
    [gotoFirstHome] = "goBack",
    [fixedHome] = "fixed",
}

-- The blocks we're allowed to mine, and what type they are.
local canMine = {
    ["minecraft:acacia_log"] = "log",
    ["minecraft:acacia_leaves"] = "leaf",
}

-- Items that we should keep in the turtle's inventory when emptying into chest.
local isImportant = {
    ["minecraft:bone_meal"] = true,
    [sapling] = true,
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
    local isBlock, data = turtle.inspectDown()
    
    if isHome[data.name] then return false end
    
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

-- Algorithm to break every log block of an acacia tree
function mineTree()
    for i=1, 4, 1 do
        if forward() then
            mineTree()
            turtle.back()
        end
        turtle.turnRight()
    end
    if up() then
        mineTree()
        turtle.down()
    end
end

-- 
function nextHome()
    turtle.turnRight()
    local isBlock, data
    
    repeat
        if turtle.forward() then
            rightCounter = rightCounter + 1
        else
            return
        end
        isBlock, data = turtle.inspectDown()
    until isHome[data.name]
    
    turtle.turnLeft()
end

-- 
function firstHome()
    turtle.turnLeft()
    while rightCounter > 0 do
        rightCounter = rightCounter - 1
        turtle.forward()
    end
    turtle.turnRight()
end

-- Flush the saplings into the corner with the water system,
-- then go collect them.
function flushSaplings()
    redstone.setOutput("bottom", true)
    sleep(1)
    redstone.setOutput("bottom", false)
    sleep(1)
    while turtle.suckUp() do end
end

-- Dump inventory of non-essential items, pick up saplings, restock, and refuel
function manageInventory()
    turtle.back()
    turtle.turnLeft()
    turtle.forward()
    
    -- Dump non-essential items downwards into a chest
    preapi.dumpInventory(isImportant, turtle.dropDown)
    
    -- Pick up the saplings from the ground
    while turtle.suck() do end
    
    -- Get more resources from chest on the left
    -- I.e. bonemeal, fuel, etc.
    turtle.turnLeft()
    while turtle.suck() do end
    turtle.turnRight()
    
    -- Refuel
    preapi.eatAllFuel(isImportant)
    
    turtle.back()
    turtle.turnRight()
    turtle.forward()
end

-- Find sapling in inventory, plant one, and eat extras
function placeSapling()
    local index = preapi.findItem(sapling)
    
    if not index then
        io.write("Error: no saplings\n")
        return false
    end
    
    turtle.select(index)
    turtle.place()
    
    local saplingCount = turtle.getItemCount()
    
    if saplingCount > 5 then
        turtle.refuel(saplingCount - 5)
    end
    
    turtle.select(1)
    return true
end

-- If we have bonemeal, use it to grow the tree
function bonemeal()
    local index = preapi.findItem("minecraft:bone_meal")
    
    if not index then return false end
    
    turtle.select(index)
    
    while turtle.place() do end
    
    turtle.select(1)
end

function woodCount()
    local count = 0
    for i=1, 16, 1 do
        local data = turtle.getItemDetail(i)
        if data then if data.name == "minecraft:acacia_log" then
            count = count + data.count
        end end
    end
    return count
end

-- 
function checkTrees()
    local isBlock, data = turtle.inspect()
    
    if canMine[data.name] == "log" then
        treeCounter = treeCounter + 1
        local fuelUsed = turtle.getFuelLevel()
        io.write("\n--- Tree "..treeCounter.." ---\n")
        
        mineTree()
        io.write(woodCount().." logs.\n")
        
        sleep(decayPeriod)
        
        flushSaplings()
        
        manageInventory()
        
        placeSapling()
        
        fuelUsed = fuelUsed - turtle.getFuelLevel()
        if fuelUsed < 0 then
            fuelUsed = fuelUsed * -1
            io.write("Gained "..fuelUsed.." fuel.\n")
        else
            io.write("Used "..fuelUsed.." fuel.\n")
        end
        io.write("Fuel: "..turtle.getFuelLevel().."\n")
        io.write("Done. Total logs mined: "..logTotal.."\n")
    else
        if not isBlock then
            placeSapling()
            bonemeal()
        elseif data.name == sapling then
            bonemeal()
        end
        
        isBlock, data = turtle.inspectDown()
        
        if isHome[data.name] == "next" then
            nextHome()
        elseif isHome[data.name] == "goBack" then
            firstHome()
        end
    end
    sleep(updatePeriod)
end

while true do
    turtle.select(1)
    checkTrees()
end

