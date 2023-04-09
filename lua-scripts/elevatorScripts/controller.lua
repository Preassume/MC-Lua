-- shell.run("controller", ch)
-- Paste the above command into a new program caled 'startup'
-- Replace 'ch' with desired modem channel.

local arg = {...}

local modem = peripheral.wrap("left")
local listenCh = tonumber(arg[1])
modem.open(listenCh)

local gearShift = "bottom"
local gearState = false -- Default resting state
rs.setOutput(gearShift, gearState)

while true do
    local event, modemSide, senderCh, replyCh, message, senderDist
    repeat
        event, modemSide, senderCh, replyCh, message, senderDist = os.pullEvent("modem_message")
    until senderCh == listenCh
    print("got message: "..message)
    
    if message == "down" then
        gearState = not gearState
        modem.transmit(replyCh, listenCh, 104)
        print("transmitted")
    elseif message == "up" then
        gearState = false
    end
    
    rs.setOutput(gearShift, gearState)
end