-- Each floor in your elevator system needs a computer running this script.
-- The way the elevator stays stationary at a floor is by using pistons
-- to block the path of the elevator. Otherwise, it would always be moving.

-- Two pistons are required for each floor computer. One must be
-- one block below the level at which you want the elevator to stop.
-- The other piston must be one block above the level at which you
-- want the elevator to stop.

-- The elevator must have a rope pulley, and so it's advisable to glue
-- one block directly beside the one attached to the rope. This glued block
-- will catch on the blocks we extend with our pistons, allowing us to stop
-- the elevator, regardless of if it is travelling up or down.

-- This script controls those pistons according to instructions sent by
-- the controller computer over rednet. Obviously this means that all
-- floor computers must have modems capable of providing connection to 
-- the controller computer.

---HOW TO USE----------------------------------------------------------

-- shell.run("floorComputer", "protocol", "floorname", "floorlevel")
-- Put the above command in a file named "startup.lua"
-- Replace 'protocol' with the same protocol you used for the controller computer
-- Replace 'floorname' with a unique name for your floor.
-- Numbers can be used, but it must still be in quotations.
-- Do not re-use the same name for multiple floors
-- Make sure the name is relatively easy to type, as that is how you will
-- access this floor via the elevator.
-- Replace 'floorlevel' with the Y-coordinate if the floor.
-- Technically it doesn't have to be the exact Y-coordinate, but it's simpler to do this.
-- It ensures that the controller knows which floors are above or below the rest of the floors.

-----------------------------------------------------------------------

local args = {...}

local protocol = args[1] or error("Error: No protocol provided.")

local floorName = args[2] or error("Error: No floor name provided.")

local floorLevel = args[3] or error("Error: No floor level provided.")

local topExtended = false
local bottomExtended = false

peripheral.find("modem", rednet.open)

while true do
    local id, msg
    repeat
        id, msg = rednet.receive(protocol)
    until msg == floorName or msg == 30
    local controllerID = id
    
    if msg == 30 then -- Who are you?
        rednet.send(controllerID, floorName, protocol) -- It's me!
    elseif msg == 31 then -- Where's the elevator?
        if redstone.getInput("front") then
            rednet.send(controllerID, floorName, protocol) -- It's here!
        end
    else -- Hey, listen up
        rednet.send(controllerID, 32, protocol) -- I'm listening!
        id, msg = rednet.receive(protocol) -- Here's what I wanna tell you
        
        if msg == "up" then
            topExtended = not topExtended
        elseif msg == "down" then
            bottomExtended = not bottomExtended
        elseif msg == "reset" then
            topExtended = false
            bottomExtended = false
        end
        
        rs.setOutput("top", topExtended)
        rs.setOutput("bottom", bottomExtended)
    end
end
