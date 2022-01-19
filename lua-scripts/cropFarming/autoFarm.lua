-- This is a simple automatic farming robot. Your farm needs to be built with the appropriate
-- blocks to tell the robot when to turn, which direction, etc.
-- Works with potatoes, carrots, wheat, beetroots, nether warts, pumpkins, melons, and sugar cane.
-- NOTE: For sugar cane, it works best if the turtle is a block higher than it would be for any other crop.

local preapi = require("commonAPI")
local hoe = "left"
local pick = "right"
local moveDelay = 1 -- How often we rest when changing direction
local restTime = 120 -- How long we wait between sweeps

-- Change these block IDs to whatever you want the turtle to detect
local rightRow = "minecraft:diorite" -- Go to the row to the right
local leftRow = "minecraft:granite" -- Go to the row to the left
local goRight = "minecraft:polished_diorite" -- Turn right once and go straight
local goLeft = "minecraft:poloshed_granite" -- Turn left once and go straight
local LorR = "minecraft:cobbled_deepslate" -- Go left or right, cycling every time we encounter it
local homeBlock = "minecraft:andesite" -- Indicate that we're back where we started
local multiHome = "minecraft:polished_andesite" -- Home block, but we start from a different side every time
-- Idea for multiHome: use hopper for that so turtle can retreat
-- underneath it during its rest periods. the hopper will fill
-- the turtle with fuel, and then the turtle can refuel when
-- it starts up again. Fuel can be supplied from another
-- turtle (i.e. bamboo farming turtle filling it with sticks)

-- Regular home could work the same way, but that home block
-- could be whatever and the turtle can still go under and get
-- hopper loaded from the side.

local shouldLeft = false -- Keeps track of which direction we should turn for LorR blocks

-- Function table: Contains the movement patterns to execute when certain blocks are detected
local blockLogic = {
    [rightRow] = function()
        turtle.turnRight()
        turtle.forward()
        turtle.turnRight()
        sleep(moveDelay)
    end,
    [leftRow] = function()
        turtle.turnLeft()
        turtle.forward()
        turtle.turnLeft()
        sleep(moveDelay)
    end,
    [goLeft] = function()
        turtle.turnLeft()
        turtle.forward()
        sleep(moveDelay)
    end,
    [goRight] = function()
        turtle.turnRight()
        turtle.forward()
        sleep(moveDelay)
    end,
    [LorR] = function()
        if shouldLeft then turtle.turnLeft()
        else turtle.turnRight() end
        shouldLeft = not shouldLeft
        turtle.forward()
        sleep(moveDelay)
    end,
    [homeBlock] = function()
        turtle.turnRight()
        turtle.turnRight()
        preapi.eatAllFuel()
        dumpInventory()
        turtle.select(1)

        io.write("resting... Fuel: ["..turtle.getFuelLevel().."]")
        sleep(restTime)
        io.write(" OK! Let's go!\n")
    end,
    [multiHome] = function()
        turtle.turnRight()
        turtle.forward()
        turtle.turnLeft()
        turtle.forward()
        turtle.turnRight()
        dumpInventory()
        turtle.select(1)

        io.write("resting... Fuel: ["..turtle.getFuelLevel().."]")
        sleep(restTime / 4)
        io.write(" OK! Let's go!\n")
    end,
    ["minecraft:sugar_cane"] = function()
        turtle.dig()
        turtle.forward()
    end,
    ["minecraft:pointed_dripstone"] = function()
        turtle.dig()
        turtle.forward()
        turtle.suckDown()
    end,
}

-- Lookup table: Finds the appropriate item to select to replant a crop
local plantLogic = {
    ["minecraft:potatoes"] = "minecraft:potato",
    ["minecraft:carrots"] = "minecraft:carrot",
    ["minecraft:wheat"] = "minecraft:wheat_seeds",
    ["minecraft:beetroots"] = "minecraft:beetroot_seeds",
    ["minecraft:nether_wart"] = "minecraft:nether_wart",
}

-- Lookup table: Finds the appropriate age to harvest a crop
local ageLogic = {
    ["minecraft:potatoes"] = 7,
    ["minecraft:carrots"] = 7,
    ["minecraft:wheat"] = 7,
    ["minecraft:beetroots"] = 3,
    ["minecraft:nether_wart"] = 3,
}

-- Lookup table: True means replant, false means do not replant.
local breakThese = {
    ["minecraft:potatoes"] = true,
    ["minecraft:carrots"] = true,
    ["minecraft:wheat"] = true,
    ["minecraft:beetroots"] = true,
    ["minecraft:pumpkin"] = false,
    ["minecraft:melon"] = false,
    ["minecraft:sugar_cane"] = false,
    ["minecraft:pointed_dripstone"] = false,
}

-- Dump everything into a chest above the turtle.
-- NOTE: If there is no chest, the turtle will make it rain
function dumpInventory()
    for i = 1, 16, 1 do
        turtle.select(i)
        turtle.dropUp()
    end
    turtle.select(1)
end

-- Check the crop directly below the turtle. Harvest if needed, replanting if needed.
function checkCrop()
    local isThere, data = turtle.inspectDown()
    
    if isThere then
        if breakThese[data.name] == true then
            if ageLogic[data.name] == data.state.age then
                turtle.digDown()
                local seed = preapi.findItem(plantLogic[data.name])
                if seed then
                    turtle.select(seed)
                    turtle.placeDown()
                    turtle.select(1)
                end
            end
        elseif breakThese[data.name] == false then
            turtle.digDown()
        end
    end
end

-- We move forward one block at a time unless we detect a block from the blockLogic table.
-- If such a block is detected, its corresponding function is executed.
function nextCrop()
    local isThere, data = turtle.inspect()
    
    if not isThere then
        turtle.forward()
    else
        if blockLogic[data.name] ~= nil then
            blockLogic[data.name]()
        end
    end
end

while true do
    checkCrop()
    
    nextCrop()
    
    if turtle.getFuelLevel() == 0 then error("OUT OF FUEL") end
end