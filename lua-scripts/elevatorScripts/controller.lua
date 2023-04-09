-- os.run({ch}, "controller.lua")
-- Paste the above command into a new program caled 'startup'
-- Replace 'ch' with desired modem channel.

local modem = peripheral.wrap("left")
local listenCh = arg[0]
modem.open(listenCh)

local gearShift = "down"
local gearState = false -- Default resting state
rs.setOutput(gearShift, gearState)

while true do
    local event, modemSide, senderCh, replyCh, message, senderDist
    repeat
        event, modemSide, senderCh, replyCh, message, senderDist = os.pullEvent("modem_message")
    until channel == listenCh
    
    if message == "down" then
        gearState = not gearState
        modem.transmit(replyCh, listenCh, 104)
    elseif message == "up" then
        gearState = false
    end
    
    rs.setOutput(gearShift, gearState)
end