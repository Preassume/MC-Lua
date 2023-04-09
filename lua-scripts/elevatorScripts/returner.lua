-- shell.run("returner", ch, floor)
-- Paste the above command into a new program caled 'startup'
-- Replace 'ch' with desired modem channel to listen on.
-- 'floor' is an optional parameter. Replace with the name of your floor, or don't include it.

local arg = {...}

local modem = peripheral.wrap("left")
local sendCh = tonumber(arg[1])

local floorName
if arg[2] then
    floorName = arg[2]
else
    floorName = "down"
end

while true do
    print("Press 'enter' to send the elevator back up, or\nPress 'space' to call the elevator.")
    local event, key = os.pullEvent("key_up")
    local name = keys.getName(key)
    if key == keys.enter then
        term.clear()
        print("Going up!")
        sleep(1)
        modem.transmit(sendCh, 0, "up")
        sleep(2)
        term.clear()
        sleep(1)
    elseif key == keys.space then
        term.clear()
        print("Calling elevator...")
        sleep(1)
        modem.transmit(sendCh, 0, floorName)
        sleep(2)
        term.clear()
        sleep(1)
    end
end