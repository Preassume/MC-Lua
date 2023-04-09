-- shell.run("returner", sendch, repch, floor)
-- Paste the above command into a new program caled 'startup'
-- Replace 'sendch' and 'repch' with desired channels for sending messages and recieving replies.
-- 'floor' is an optional parameter. Replace with the name of your floor, or don't include it.

local arg = {...}

local modem = peripheral.wrap("left")
local sendCh = tonumber(arg[1])
local replyCh = tonumber(arg[2])

local floorName
if arg[3] then
    floorName = arg[3]
else
    floorName = "down"
end

while true do
    print("Press 'enter' to send the elevator back up, or\nPress 'space' to call the elevator.")
    local event, key = os.pullEvent("key_up")
    local name = keys.getName(key)
    if key == keys.equals then
        term.clear()
        print("Going up!")
        sleep(1)
        modem.transmit(sendCh, 0, "up")
        sleep(2)
        term.clear()
        sleep(1)
    elseif key == keys.minus then
        if floorName == "down" or floorName == "up" then
            term.clear()
            print("Calling elevator...")
            sleep(1)
            modem.transmit(sendCh, 0, floorName)
            sleep(2)
            term.clear()
            sleep(1)
        else
            term.clear()
            print("Searching for floor '"..floorName.."' ...")
            modem.transmit(sendCh, replyCh, input)
            print("Press any key to cancel.")
            
            local searching = true
            while searching do
                local eventData = {os.pullEvent()}
                local event = eventData[1]

                if event == "modem_message" then
                    if eventData[5] == 104 then
                        modem.transmit(sendCh, replyCh, "down")
                        searching = false
                        print("Found floor '"..floorName.."' !")
                        sleep(3)
                        term.clear()
                    end
                elseif event == "key" then
                    searching = false
                    print("Stopping search ...")
                    sleep(1)
                    term.clear()
                end
            end
        end
    end
end