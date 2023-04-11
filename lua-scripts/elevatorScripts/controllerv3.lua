-- This script will control the elevator.

-- It will listen to requests to send the elevator to a floor,
-- and take the necessary steps to get it there.

-- The computer running this script should be placed on top of the
-- rope pulley which handles the elevator movement.

-- This computer will not be taking text input from the user, rather
-- it will communicate exclusively over rednet.

-- Therefore, a modem which can connect to all other computers
-- in the elevator system is necessary.

-- All commands issued to this computer must be done over rednet.

---HOW TO USE----------------------------------------------------------

-- shell.run("controllerv2", "protocol")
-- Place the above command into a new file named startup.lua
-- Replace 'protocol' with your desired rednet protocol (in quotations)

-----------------------------------------------------------------------

local args = {...}

local protocol = args[1] or error("Error: No protocol provided.")

local gearShift = "bottom"

peripheral.find("modem", rednet.open)

local goingUp = true

local floorLevels = {}
local floorIDs = {}
local floorString

local function clearScrn()
    term.clear()
    term.setCursorPos(1, 1)
end

local function getFloors()
    local function getNum(msg) return tonumber(msg:match("[+-]?%d+")) end
    local function getName(msg) return msg:gsub("[+-]?%d+", "") end
    
    rednet.broadcast(30, protocol) -- 30 means "everybody tell me who you are"
    repeat
        local id, msg = rednet.receive(protocol, 3)
        if msg then
            local floorNum = getNum(msg)
            local floorName = getName(msg)
            floorLevels[floorName] = floorNum
            floorIDs[floorName] = id
        end
    until not msg
    
    floorString = ""
    for num, name in pairs(floors) do
        floorString = floorString..name.."\n"
    end
end

local function controlFloor(name, direction)
    rednet.broadcast(name, protocol) -- Look for the requested floor computer
    local id, msg = rednet.receive(protocol, 3)
    
    if msg == 32 then -- 32 means "I'm here and listening!"
        rednet.send(id, direction, protocol)
        return true
    else
        return false
    end
end

local function gotoFloor(name, ID)
    if not floorLevels[name] then
        rednet.send(ID, 39, protocol) -- Floor disabled or doesn't exist
        return
    end
    rednet.broadcast(31, protocol) -- Where is the elevator? Asks all floor computers
    id, msg = rednet.receive(protocol, 3)
    if not msg then
        rednet.send(ID, 38, protocol) -- Elevator busy
        return
    elseif msg == name then
        rednet.send(ID, 37, protocol) -- Elevator is already there
        return
    end
    
    controlFloor(msg, "reset")
    if floorLevels[name] < floorLevels[msg] then
        if goingUp then
            goingUp = not goingUp
        end
        controlFloor(name, "down")
    elseif floorLevels[name] > floorLevels[msg] then
        if not goingUp then
            goingUp = not goingUp
        end
        controlFloor(name, "up")
    end
    
    sleep(1)
end

print("Starting up.")
sleep(1)
clearScrn()
print("Starting up..")
sleep(1)
clearScrn()
print("Starting up...")

getFloors()

clearScrn()
for num, name in pairs(floors) do
    print(num, name)
end

while true do
    local id, msg = rednet.receive(protocol)
    if msg == "refresh" then
        getFloors()
    elseif msg == 33 then
        rednet.send(id, floorString, protocol)
    elseif msg == 34 then
        rednet.send(id, 32, protocol)
    elseif msg == "up" then
        goingUp = true
    elseif msg == "down" then
        goingUp = false
    else
        msg = msg..floorlevels[msg]
        gotoFloor(msg, id)
    end
    
    rs.setOutput(gearShift, not goingUp)
end