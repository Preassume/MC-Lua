-- shell.run("floorComputerv2", "protocol", "floorname", "floorlevel")

local args = {...}

local protocol = args[1] or error("Error: No protocol provided.")
protocol = protocol.."-floor"

local floorName = args[2] or error("Error: No floor name provided.")

local floorLevel = tonumber(args[3]) or error("Error: No floor level provided.")

local floorInfo = floorName..floorLevel

local topExtended = rs.getOutput("top")
local bottomExtended = rs.getOutput("bottom")

peripheral.find("modem", rednet.open)

local elevatorCodes = {
    [30] = function(id) rednet.send(id, floorInfo, protocol) end, -- Who is everyone?
    [31] = function(id) -- Where is the elevator?
        if rs.getInput("front") then
            rednet.send(id, 35, protocol)
        end
    end, 
    [32] = function(id) end, -- Affirmative / I'm listening
    [33] = function(id) end, -- Send me the floor string
    [34] = function(id) end, -- Who's the controller?
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

clearScrn()
print("Floor computer for '"..floorName.."' on level "..floorLevel)

while true do
    local id, msg = rednet.receive(protocol)
    
    if msg then
        print(id, msg)
        if elevatorCodes[msg] then
            elevatorCodes[msg](id)
        elseif msg == "top" then
            topExtended = not topExtended
        elseif msg == "bottom" then
            bottomExtended = not bottomExtended
        elseif msg == "reset" then
            bottomExtended = false
            topExtended = false
        end
        rs.setOutput("top", topExtended)
        rs.setOutput("bottom", bottomExtended)
    end
end