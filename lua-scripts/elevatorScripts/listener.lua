-- os.run({ch, cmd}, "listener.lua")
-- Paste the above command into a new program caled 'startup'
-- Replace 'ch' and 'cmd' with desired parameters.

local arg = ...

local modem = peripheral.wrap("left")
local listenCh = arg[1]
modem.open(listenCh)

local toggleCommand = arg[2]

local piston = "right"
local pistonState = false -- Default resting state
rs.setOutput(piston, pistonState)

while true do
    local event, modemSide, senderCh, replyCh, message, senderDist
    repeat
        event, modemSide, senderCh, replyCh, message, senderDist = os.pullEvent("modem_message")
    until channel == listenCh
    
    if message == toggleCommand then
        pistonState = not pistonState
        modem.transmit(replyCh, listenCh, 104)
    elseif message == "up" then
        pistonState = false
    end
    
    rs.setOutput(piston, pistonState)
end