-- shell.run("controllerv3", "protocol")

local args = {...}

local protocol = args[1] or error("Error: No protocol provided.")

local gearShift = "bottom"

peripheral.find("modem", rednet.open)

local goingUp = true

local floorLevels = {}
local floorString = ""

local elevatorCodes = {
    [30] = function(id) end, -- Who is everyone?
    [31] = function(id) end, -- Where is the elevator?
    [32] = function(id) end, -- Affirmative / I'm listening
    [33] = function(id) rednet.send(id, floorString, protocol) end, -- Send me the floor string
    [34] = function(id) rednet.send(id, os.computerID(), protocol) end, -- Who's the controller?
    [35] = function(id) end,
    [36] = function(id) end,
    [37] = function(id) end, -- Elevator is already at requested floor
    [38] = function(id) end, -- Elevator is busy
    [39] = function(id) end, -- Floor disabled or doesn't exist
}

local function clearScrn()
    term.clear()
    term.setCursorPos(1, 1)
end

local function addFloor(floor)
    local function getNum(floor) return tonumber(floor:match("[+-]?%d+")) end
    local function getName(floor) return floor:gsub("[+-]?%d+", "") end
    
    local floorName = getName(floor)
    if floorLevels[floorName] then return end
    local floorNum = getNum(floor)
    
    floorLevels[floorName] = floorNum
    
    floorString = floorString..floorName.."\n"
    clearScrn()
    print(floorString)
end

clearScrn()
print("Starting...")
sleep(3)
clearScrn()

while true do
    local id, msg
    id, msg = rednet.receive(protocol)
    print(id, msg)
    
    if msg then
        if elevatorCodes[msg] then
            elevatorCodes[msg](id)
        elseif msg == msg:match("%w+[+-]?%d+") then
            addFloor(msg)
        end
    end
end