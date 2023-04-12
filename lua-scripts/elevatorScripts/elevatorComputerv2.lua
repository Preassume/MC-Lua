-- shell.run("elevatorComputerv2", "protocol")

local args = {...}

local protocol = args[1] or error("Error: No protocol provided.")

local elevatorCodes = {
    [30] = function(id) end, -- Who is everyone?
    [31] = function(id) end, -- Where is the elevator?
    [32] = function(id) end, -- Affirmative / I'm listening
    [33] = function(id) end, -- Send me the floor string
    [34] = function(id) end, -- Who's the controller?
    [35] = function(id) end,
    [36] = function(id) end,
    [37] = function(id) end, -- Elevator is already at requested floor
    [38] = function(id) end, -- Elevator is busy
    [39] = function(id) end, -- Floor disabled or doesn't exist
}

while true do
    
end