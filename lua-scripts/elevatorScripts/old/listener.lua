-- shell.run("listener", ch, cmd)
-- Paste the above command into a new program caled 'startup'
-- Replace 'ch' and 'cmd' with desired parameters.

local arg = {...}

local modem = peripheral.wrap("left")
local listenCh = tonumber(arg[1])
modem.open(listenCh)

local toggleCommand = arg[2]

local piston = "right"
local pistonState = false -- Default resting state
rs.setOutput(piston, pistonState)

while true do
    local event, modemSide, senderCh, replyCh, message, senderDist
    repeat
        event, modemSide, senderCh, replyCh, message, senderDist = os.pullEvent("modem_message")
    until senderCh == listenCh
    print("got message: "..message)
    
    if message == toggleCommand then
        pistonState = not pistonState
        modem.transmit(replyCh, listenCh, 104)
        print("transmitted")
    elseif message == "up" then
        pistonState = false
    end
    
    rs.setOutput(piston, pistonState)
end