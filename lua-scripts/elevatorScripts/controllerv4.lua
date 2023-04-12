-- shell.run("controllerv4", "protocol")

local args = {...}

local protocol = args[1] or error("Error: No protocol provided.")

local gearShift = "bottom"

peripheral.find("modem", rednet.open)

local goingUp = not rs.getOutput("bottom")

local floorLevels = {}
local floorIDs = {}
local floorString = ""

local elevatorCodes = {
    [30] = function(id) end, -- Who is everyone?
    [31] = function(id) end, -- Where is the elevator?
    [32] = function(id) end, -- Affirmative / I'm listening
    [33] = function(id) rednet.send(id, floorString, protocol) end, -- Send me the floor string
    [34] = function(id) rednet.send(id, os.computerID(), protocol) end, -- Who's the controller?
    [35] = function(id) end, -- The elevator is at my location
    [36] = function(id) end,
    [37] = function(id) end, -- Elevator is already at requested floor
    [38] = function(id) end, -- Elevator is busy
    [39] = function(id) end, -- Floor disabled or doesn't exist
}

local function clearScrn()
    term.clear()
    term.setCursorPos(1, 1)
end

local function addFloor(ID, floor)
    local function getNum(floor) return tonumber(floor:match("[+-]?%d+")) end
    local function getName(floor) return floor:gsub("[+-]?%d+", "") end
    
    local floorName = getName(floor)
    if floorLevels[floorName] then return end
    local floorNum = getNum(floor)
    
    floorLevels[floorName] = floorNum
    floorIDs[floorName] = ID
    
    floorString = floorString..floorName.."\n"
    print(ID, floorName, floorNum)
end

local function refreshFloorList()
    floorLevel = {}
    floorIDs = {}
    floorString = ""
    rednet.broadcast(30, protocol)
end

local function gotoFloor(floor)
    
end

clearScrn()
print("Starting...")
sleep(3)
clearScrn()

refreshFloorList()

while true do
    local id, msg
    id, msg = rednet.receive(protocol)
    
    if msg then
        print(id, msg)
        if elevatorCodes[msg] then
            elevatorCodes[msg](id)
        elseif msg == msg:match("%w+[+-]?%d+") then
            addFloor(id, msg)
        elseif floorLevels[msg] ~= nil then
            gotoFloor(msg)
        elseif msg == "up" then
            goingUp = true
        elseif msg == "down" then
            goingUp = false
        elseif msg == "refresh" then
            refreshFloorList()
        else
            rednet.send(id, 39, protocol)
        end
        rs.setOutput("bottom", not goingUp)
    end
end