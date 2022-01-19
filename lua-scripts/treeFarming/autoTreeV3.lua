local updatePeriod = 5 -- How frequently we check if a tree has grown
local decayPeriod = 60 -- How long we wait for leaves to decay

local preapi = require("commonAPI")

local acacia = require("acacia")

-- The blocks we use as "home" points (right in front of sapling)
-- Edit these two to change what kind of blocks you want to use
-- to indicate home points
local homeTypes = {
    ["minecraft:granite"] = "minecraft:acacia_sapling",
    ["minecraft:diorite"] = "minecraft:birch_sapling",
}

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
    ["minecraft:acacia_sapling"] = true,
    ["minecraft:oak_sapling"] = true,
    ["minecraft:birch_sapling"] = true,
    ["minecraft:jungle_sapling"] = true,
    ["minecraft:dark_oak_sapling"] = true,
    ["minecraft:spruce_sapling"] = true,
}

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
    local isBlock, data = turtle.inspectDown()
    
    if not isBlock then
        error("Error: no home block found")
        return false
    end
    
    local index = preapi.findItem(homeTypes[data.name])
    
    if not index then
        io.write("Error: no "..homeTypes[data.name].." saplings in inventory.\n")
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

