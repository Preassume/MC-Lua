-- os.run({ch}, "controller.lua")
-- Paste the above command into a new program caled 'startup'
-- Replace 'ch' with desired modem channel.

local modem = peripheral.wrap("left")
local sendCh = arg[0]

while true do
    print("Press 'y' to send the elevator back up:")
    local event, key = os.pullEvent("key_up")
    local name = keys.getName(key)
    if key == keys.y then
        term.clear()
        print("Going up!")
        sleep(1)
        modem.transmit(ch, 0, "up")
    end
    sleep(2)
    term.clear()
    sleep(1)
end