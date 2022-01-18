local preapi = {}

preapi.isFuel = {
    ["minecraft:lava_bucket"] = true,
    ["minecraft:coal_block"] = true,
    ["minecraft:dried_kelp_block"] = true,
    ["minecraft:blaze_rod"] = true,
    ["minecraft:coal"] = true,
    ["minecraft:charcoal"] = true,
    ["minecraft:oak_boat"] = true,
    ["minecraft:spruce_boat"] = true,
    ["minecraft:birch_boat"] = true,
    ["minecraft:jungle_boat"] = true,
    ["minecraft:acacia_boat"] = true,
    ["minecraft:scaffolding"] = true,
    ["minecraft:bee_nest"] = true,
    ["minecraft:beehive"] = true,
    ["minecraft:birch_log"] = true,
    ["minecraft:dark_oak_log"] = true,
    ["minecraft:oak_log"] = true,
    ["minecraft:acacia_log"] = true,
    ["minecraft:spruce_log"] = true,
    ["minecraft:jungle_log"] = true,
    ["minecraft:warped_stem"] = true,
    ["minecraft:crimson_stem"] = true,
    ["minecraft:stripped_oak_log"] = true,
    ["minecraft:stripped_jungle_log"] = true,
    ["minecraft:stripped_spruce_log"] = true,
    ["minecraft:stripped_birch_log"] = true,
    ["minecraft:stripped_acacia_log"] = true,
    ["minecraft:stripped_dark_oak_log"] = true,
    ["minecraft:stripped_warped_stem"] = true,
    ["minecraft:stripped_crimson_stem"] = true,
    ["minecraft:birch_wood"] = true,
    ["minecraft:jungle_wood"] = true,
    ["minecraft:dark_oak_wood"] = true,
    ["minecraft:spruce_wood"] = true,
    ["minecraft:acacia_wood"] = true,
    ["minecraft:oak_wood"] = true,
    ["minecraft:crimson_hyphae"] = true,
    ["minecraft:warped_hyphae"] = true,
    ["minecraft:stripped_birch_wood"] = true,
    ["minecraft:stripped_jungle_wood"] = true,
    ["minecraft:stripped_dark_oak_wood"] = true,
    ["minecraft:stripped_spruce_wood"] = true,
    ["minecraft:stripped_acacia_wood"] = true,
    ["minecraft:stripped_oak_wood"] = true,
    ["minecraft:stripped_crimson_hyphae"] = true,
    ["minecraft:stripped_warped_hyphae"] = true,
    ["minecraft:spruce_planks"] = true,
    ["minecraft:jungle_planks"] = true,
    ["minecraft:birch_planks"] = true,
    ["minecraft:acacia_planks"] = true,
    ["minecraft:dark_oak_planks"] = true,
    ["minecraft:oak_planks"] = true,
    ["minecraft:warped_planks"] = true,
    ["minecraft:crimson_planks"] = true,
    ["minecraft:spruce_slab"] = true,
    ["minecraft:acacia_slab"] = true,
    ["minecraft:jungle_slab"] = true,
    ["minecraft:oak_slab"] = true,
    ["minecraft:dark_oak_slab"] = true,
    ["minecraft:birch_slab"] = true,
    ["minecraft:crimson_slab"] = true,
    ["minecraft:warped_slab"] = true,
    ["minecraft:dark_oak_stairs"] = true,
    ["minecraft:spruce_stairs"] = true,
    ["minecraft:birch_stairs"] = true,
    ["minecraft:acacia_stairs"] = true,
    ["minecraft:jungle_stairs"] = true,
    ["minecraft:oak_stairs"] = true,
    ["minecraft:warped_stairs"] = true,
    ["minecraft:crimson_stairs"] = true,
    ["minecraft:oak_pressure_plate"] = true,
    ["minecraft:spruce_pressure_plate"] = true,
    ["minecraft:dark_oak_pressure_plate"] = true,
    ["minecraft:acacia_pressure_plate"] = true,
    ["minecraft:jungle_pressure_plate"] = true,
    ["minecraft:birch_pressure_plate"] = true,
    ["minecraft:warped_pressure_plate"] = true,
    ["minecraft:crimson_pressure_plate"] = true,
    ["minecraft:spruce_button"] = true,
    ["minecraft:acacia_button"] = true,
    ["minecraft:dark_oak_button"] = true,
    ["minecraft:oak_button"] = true,
    ["minecraft:jungle_button"] = true,
    ["minecraft:birch_button"] = true,
    ["minecraft:warped_button"] = true,
    ["minecraft:crimson_button"] = true,
    ["minecraft:birch_trapdoor"] = true,
    ["minecraft:jungle_trapdoor"] = true,
    ["minecraft:dark_oak_trapdoor"] = true,
    ["minecraft:spruce_trapdoor"] = true,
    ["minecraft:oak_trapdoor"] = true,
    ["minecraft:acacia_trapdoor"] = true,
    ["minecraft:crimson_trapdoor"] = true,
    ["minecraft:warped_trapdoor"] = true,
    ["minecraft:birch_fence_gate"] = true,
    ["minecraft:spruce_fence_gate"] = true,
    ["minecraft:dark_oak_fence_gate"] = true,
    ["minecraft:jungle_fence_gate"] = true,
    ["minecraft:oak_fence_gate"] = true,
    ["minecraft:acacia_fence_gate"] = true,
    ["minecraft:crimson_fence_gate"] = true,
    ["minecraft:warped_fence_gate"] = true,
    ["minecraft:oak_fence"] = true,
    ["minecraft:jungle_fence"] = true,
    ["minecraft:acacia_fence"] = true,
    ["minecraft:birch_fence"] = true,
    ["minecraft:spruce_fence"] = true,
    ["minecraft:dark_oak_fence"] = true,
    ["minecraft:crimson_fence"] = true,
    ["minecraft:warped_fence"] = true,
    ["minecraft:ladder"] = true,
    ["minecraft:crafting_table"] = true,
    ["minecraft:cartography_table"] = true,
    ["minecraft:fletching_table"] = true,
    ["minecraft:smithing_table"] = true,
    ["minecraft:loom"] = true,
    ["minecraft:bookshelf"] = true,
    ["minecraft:composter"] = true,
    ["minecraft:chest"] = true,
    ["minecraft:trapped_chest"] = true,
    ["minecraft:barrel"] = true,
    ["minecraft:daylight_detector"] = true,
    ["minecraft:jukebox"] = true,
    ["minecraft:note_block"] = true,
    ["minecraft:brown_mushroom_block"] = true,
    ["minecraft:red_mushroom_block"] = true,
    ["minecraft:mushroom_stem"] = true,
    ["minecraft:banner"] = true,
    ["minecraft:crossbow"] = true,
    ["minecraft:bow"] = true,
    ["minecraft:fishing_rod"] = true,
    ["minecraft:fishing_rod"] = true,
    ["minecraft:jungle_door"] = true,
    ["minecraft:spruce_door"] = true,
    ["minecraft:wooden_door"] = true,
    ["minecraft:acacia_door"] = true,
    ["minecraft:dark_oak_door"] = true,
    ["minecraft:birch_door"] = true,
    ["minecraft:warped_door"] = true,
    ["minecraft:crimson_door"] = true,
    ["minecraft:oak_sign"] = true,
    ["minecraft:dark_oak_sign"] = true,
    ["minecraft:spruce_sign"] = true,
    ["minecraft:acacia_sign"] = true,
    ["minecraft:birch_sign"] = true,
    ["minecraft:jungle_sign"] = true,
    ["minecraft:crimson_sign"] = true,
    ["minecraft:warped_sign"] = true,
    ["minecraft:birch_wall_sign"] = true,
    ["minecraft:oak_wall_sign"] = true,
    ["minecraft:spruce_wall_sign"] = true,
    ["minecraft:dark_oak_wall_sign"] = true,
    ["minecraft:jungle_wall_sign"] = true,
    ["minecraft:acacia_wall_sign"] = true,
    ["minecraft:crimson_wall_sign"] = true,
    ["minecraft:warped_wall_sign"] = true,
    ["minecraft:iron_shovel"] = true,
    ["minecraft:iron_hoe"] = true,
    ["minecraft:iron_pickaxe"] = true,
    ["minecraft:iron_sword"] = true,
    ["minecraft:iron_axe"] = true,
    ["minecraft:golden_shovel"] = true,
    ["minecraft:golden_hoe"] = true,
    ["minecraft:golden_pickaxe"] = true,
    ["minecraft:golden_sword"] = true,
    ["minecraft:golden_axe"] = true,
    ["minecraft:stone_shovel"] = true,
    ["minecraft:stone_hoe"] = true,
    ["minecraft:stone_pickaxe"] = true,
    ["minecraft:stone_sword"] = true,
    ["minecraft:stone_axe"] = true,
    ["minecraft:wooden_shovel"] = true,
    ["minecraft:wooden_hoe"] = true,
    ["minecraft:wooden_pickaxe"] = true,
    ["minecraft:wooden_sword"] = true,
    ["minecraft:wooden_axe"] = true,
    ["minecraft:bowl"] = true,
    ["minecraft:jungle_sapling"] = true,
    ["minecraft:dark_oak_sapling"] = true,
    ["minecraft:spruce_sapling"] = true,
    ["minecraft:birch_sapling"] = true,
    ["minecraft:acacia_sapling"] = true,
    ["minecraft:oak_sapling"] = true,
    ["minecraft:stick"] = true,
    ["minecraft:azalea"] = true,
    ["minecraft:flowering_azalea"] = true,
    ["minecraft:black_wool"] = true,
    ["minecraft:magenta_wool"] = true,
    ["minecraft:light_gray_wool"] = true,
    ["minecraft:light_blue_wool"] = true,
    ["minecraft:red_wool"] = true,
    ["minecraft:gray_wool"] = true,
    ["minecraft:white_wool"] = true,
    ["minecraft:purple_wool"] = true,
    ["minecraft:orange_wool"] = true,
    ["minecraft:pink_wool"] = true,
    ["minecraft:brown_wool"] = true,
    ["minecraft:yellow_wool"] = true,
    ["minecraft:blue_wool"] = true,
    ["minecraft:green_wool"] = true,
    ["minecraft:cyan_wool"] = true,
    ["minecraft:lime_wool"] = true,
    ["minecraft:black_carpet"] = true,
    ["minecraft:magenta_carpet"] = true,
    ["minecraft:yellow_carpet"] = true,
    ["minecraft:cyan_carpet"] = true,
    ["minecraft:lime_carpet"] = true,
    ["minecraft:red_carpet"] = true,
    ["minecraft:white_carpet"] = true,
    ["minecraft:purple_carpet"] = true,
    ["minecraft:brown_carpet"] = true,
    ["minecraft:light_blue_carpet"] = true,
    ["minecraft:green_carpet"] = true,
    ["minecraft:orange_carpet"] = true,
    ["minecraft:gray_carpet"] = true,
    ["minecraft:light_gray_carpet"] = true,
    ["minecraft:pink_carpet"] = true,
    ["minecraft:blue_carpet"] = true,
    ["minecraft:bamboo"] = true,
    ["minecraft:bamboo_sapling"] = true,
    ["minecraft:gold_nugget"] = true,
    ["minecraft:iron_nugget"] = true,
    ["minecraft:nether_brick"] = true,
}

-- Consume absolutely everything in the inventory that can be used as fuel
-- Optionally, a table of important items can be passed in.
-- The turtle will not eat the items in that table.
function preapi.eatAllFuel(isImportant)
    if turtle.getFuelLevel() == turtle.getFuelLimit() then return end
    local slot = turtle.getSelectedSlot()
    local data
    for i = 1, 16, 1 do
        data = turtle.getItemDetail(i)
        if isImportant then
            if data then if preapi.isFuel[data.name] and not isImportant[data.name] then
                turtle.select(i)
                turtle.refuel()
            end end
        else
            if data then if preapi.isFuel[data.name] then
                turtle.select(i)
                turtle.refuel()
            end end
        end
    end
    turtle.select(slot)
end

-- Legacy version
-- Consume absolutely everything in the inventory that can be used as fuel
function preapi.eatAllFuelOld()
    if turtle.getFuelLevel() == turtle.getFuelLimit() then return end
    for i = 1, 16, 1 do
        turtle.select(i)
        turtle.refuel()
    end
end

-- Dump all inventory items except ones provided in table
function preapi.dumpInventory(isImportant, dropFn)
    local index = turtle.getSelectedSlot()
    local data
    for i = 1, 16, 1 do
        data = turtle.getItemDetail(i)
        if data then
            turtle.select(i)
            if isImportant then
                if not isImportant[data.name] then
                    if dropFn then dropFn()
                    else turtle.drop() end
                end
            else
                if dropFn then dropFn()
                else turtle.drop() end
            end
        end
    end
    turtle.select(index)
end

--Search the inventory for a specific item and return its slot number if it's there
--Otherwise, return false
function preapi.findItem(itemName)
    local data
    for i = 1, 16, 1 do
        if(turtle.getItemDetail(i) ~= nil) then
            data = turtle.getItemDetail(i)
            if(data.name == itemName) then
                return i
            end
        end
    end
    
    return false
end

-- Perform a sequence of movements. Returns the amount of fuel used
function preapi.movePattern(pattern)
    local fuelUsage = 0
    for n, dir in ipairs(pattern) do
        if dir == 'L' then
            turtle.turnLeft()
        elseif dir == 'R' then
            turtle.turnRight()
        elseif dir == 'F' then
            turtle.forward()
            fuelUsage = fuelUsage + 1
        elseif dir == 'B' then
            turtle.back()
            fuelUsage = fuelUsage + 1
        elseif dir == 'U' then
            turtle.up()
            fuelUsage = fuelUsage + 1
        elseif dir == 'D' then
            turtle.down()
            fuelUsage = fuelUsage + 1
        end 
    end
    return fuelUsage
end

-- Same function as movePattern, but also sucks with every movement
function preapi.suckPattern(pattern)
    local fuelUsage = 0
    for n, dir in ipairs(pattern) do
        if dir == 'L' then
            turtle.turnLeft()
            turtle.suck()
        elseif dir == 'R' then
            turtle.turnRight()
            turtle.suck()
        elseif dir == 'F' then
            turtle.forward()
            turtle.suck()
            fuelUsage = fuelUsage + 1
        elseif dir == 'B' then
            turtle.back()
            turtle.suck()
            fuelUsage = fuelUsage + 1
        elseif dir == 'U' then
            turtle.up()
            turtle.suck()
            fuelUsage = fuelUsage + 1
        elseif dir == 'D' then
            turtle.down()
            turtle.suck()
            fuelUsage = fuelUsage + 1
        end 
    end
    return fuelUsage
end

-- Does the same thing as doPattern, but reads the table in reverse
-- and moves in the opposite direction
function preapi.backtrack(pattern)
    local fuelUsage = 0
    for i=1, #pattern do
        local dir = pattern[#pattern + 1 - i]
        if dir == 'L' then
            turtle.turnRight()
        elseif dir == 'R' then
            turtle.turnLeft()
        elseif dir == 'F' then
            turtle.back()
            fuelUsage = fuelUsage + 1
        elseif dir == 'B' then
            turtle.forward()
            fuelUsage = fuelUsage + 1
        elseif dir == 'U' then
            turtle.down()
            fuelUsage = fuelUsage + 1
        elseif dir == 'D' then
            turtle.up()
            fuelUsage = fuelUsage + 1
        end 
    end
    return fuelUsage
end

return preapi