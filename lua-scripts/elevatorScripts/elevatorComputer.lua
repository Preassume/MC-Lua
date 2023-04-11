-- This script is to be run on the computer placed on the elevator itself.
-- The elevator computer can tell the controller to take the elevator directly to any floor.

-- Every time the elevator moves, this computer will restart,
-- so it's extra important that you create a startup.lua file to run this on startup.
-- Otherwise it'd be annoying.

---HOW TO USE----------------------------------------------------------

-- shell.run("floorComputer", "protocol")
-- Put the above command in a file named "startup.lua"
-- Replace 'protocol' with the same protocol you used for the controller computer

-----------------------------------------------------------------------

local args = {...}

local protocol = args[1] or error("Error: No protocol provided.")

local controllerID = false

peripheral.find("modem", rednet.open)

local function getFloors()
    rednet.broadcast(33, protocol) -- What floors exist?
    local id, msg = rednet.receive(protocol, 3)
    return msg
end

local function printFloors()
    local floors = getFloors()
    print(floors)
end

while true do
    term.clear()
    term.setCursorPos(1, 1)
    printFloors()
    print("What floor would you like to go to?")
    local input = read()
    
    local id, msg
    local count = 0
    repeat
        rednet.broadcast(34, protocol) -- Who's the controller?
        id, msg = rednet.receive(protocol, 2)
        count = count + 1
    until id or count > 3
    
    if not id then
        print("Timed out waiting for controller.")
        sleep(2)
    else
        rednet.send(id, input, protocol)
        local i, m
        local count = 0
        repeat
            i, m = rednet.receive(protocol, 1)
            count = count + 1
        until m and ((m >= 37 and m <= 39) or count > 2)
        if m == 37 then
            print("Already on that floor.")
            sleep(2)
        elseif m == 38 then
            print("The elevator is busy.")
            sleep(2)
        elseif m == 39 then
            print("The requested floor doesn't exist or is down for maintenance.")
            sleep(2)
        else
            print("Here we go!")
            sleep(2)
        end
    end
end