-- shell.run("controllerv4", "protocol")

local args = {...}

local protocol = args[1] or error("Error: No protocol provided.")
local floorProtocol = protocol.."-floor"

local gearShift = "bottom"

peripheral.find("modem", rednet.open)

local goingUp = not rs.getOutput("bottom")

local floorLevels = {}
local floorIDs = {}
local floorString = ""

local getRednet

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

local function getMsg()
    local id, msg, prot = rednet.receive()
    if prot and (prot == protocol or prot == floorProtocol) then
        return id, msg, prot
    end
end

local function addFloor(ID, floor)
    local function getNum(floor) return tonumber(floor:match("[+-]?%d+")) end
    local function getName(floor) return floor:gsub("[+-]?%d+", "") end
    
    local floorName = getName(floor)
    if floorLevels[floorName] then return end
    local floorNum = getNum(floor)
    
    floorLevels[floorName] = floorNum
    floorIDs[ID] = floorName
    
    floorString = floorString..floorName.."\n"
    print(ID, floorName, floorNum)
end

local function refreshFloorList()
    floorLevel = {}
    floorIDs = {}
    floorString = ""
    rednet.broadcast(30, floorProtocol)
end

local function getID(floor)
    for id, flr in pairs(floorIDs) do
        if flr == floor then
            return id
        end
    end
    return false
end

local function findElevator()
    local id, msg
    local count = 0
    repeat
        rednet.broadcast(31, floorProtocol)
        id, msg = getMsg()
        
        if msg and msg == 35 then
            return id
        elseif msg then
            getRednet(id, msg)
        end
        
        count = count + 1
    until count > 2
    return false
end

local function gotoFloor(id, floor)
    print("Command: go to "..floor)
    
    local locationID = findElevator()
    
    if not locationID then
        print(">".."38")
        rednet.send(id, 38, protocol)
        return
    end
    
    local destinationID = getID(floor)
    if not destinationID then
        print(">".."39")
        rednet.send(id, 39, protocol)
        return
    end
    
    local locationLevel = floorLevels[floorIDs[locationID]]
    local destinationLevel = floorLevels[floor]
    
    print(locationLevel, destinationLevel)
    print(locationLevel == destinationLevel, locationLevel < destinationLevel, locationLevel > destinationLevel)
    
    if locationLevel == destinationLevel then
        print(">".."38")
        rednet.send(id, 37, protocol)
        return
    elseif destinationLevel < locationLevel then -- Floor is lower
        goingUp = false
        rednet.send(destinationID, "bottom", floorProtocol)
    elseif destinationLevel > locationLevel then -- Floor is higher
        goingUp = true
        rednet.send(destinationID, "top", floorProtocol)
    end
    rednet.send(locationID, "reset", floorProtocol)
end

getRednet = function(id, msg)
    if msg then
        print(id, msg)
        if elevatorCodes[msg] then
            elevatorCodes[msg](id)
        elseif msg == msg:match("%w+[+-]?%d+") then
            addFloor(id, msg)
        elseif floorLevels[msg] ~= nil then
            gotoFloor(id, msg)
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

clearScrn()
print("Starting...")
sleep(3)
clearScrn()

refreshFloorList()

while true do
    local id, msg, prot = getMsg()
    if msg then
        getRednet(id, msg)
    end
    --[[id, msg, prot = rednet.receive()
    if prot and (prot == protocol or prot == floorProtocol) then
        getRednet(id, msg)
    end]]
end