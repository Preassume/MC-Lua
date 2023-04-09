-- shell.run("returner", ch)
-- Paste the above command into a new program caled 'startup'
-- Replace 'ch' with desired modem channel to listen on.

local arg = {...}

local modem = peripheral.wrap("left")
local sendCh = tonumber(arg[1])

while true do
    print("Press 'enter' to send the elevator back up:")
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
    end
end