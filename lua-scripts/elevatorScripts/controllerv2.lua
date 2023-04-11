-- shell.run("controllerv2", protocol)
-- Place the above command into a new file named startup.lua
-- Replace 'protocol' with your desired rednet protocol

local args = {...}

local protocol = args[1] or error("Error: no protocol provided")

peripheral.find("modem", rednet.open)

local floorNumbers = {}

local floorNames = {}

local function getFloors()
    local function getNum(msg) return tonumber(msg:match("[+-]?%d+")) end
    local function getName(msg) return msg:gsub("[+-]?%d+", "") end
    local floors = {}
    
    rednet.broadcast(30, protocol)
    repeat
        local id, msg = rednet.recieve(protocol, 3)
        if msg then
            local floorNum = getNum(msg)
            local floorName = getName(msg)
            floors[floorNum] =  floorName
        end
    until not msg
    
    return floors
end

local function sortFloors(floors)
    for num, name in pairs(floors) do
        table.insert(floorNumbers, num)
    end
    table.sort(floorNumbers)
    for _, num in ipairs(floorNumbers) do
        table.insert(floorNames, floors[num])
    end
end

local function gotoFloor(name)
    
end

sleep(1)