-- shell.run("caller", ch, replych, floors)
-- Paste the above command into a new program caled 'startup'
-- Replace 'ch' with desired modem channel.
-- Replaca 'replych' with desired modem reply channel.
-- Replace 'floors' with a table containing the floor names you wish to display
-- NOTE: 'floors' is purely visual and optional.

local arg = ...

local sendCh = tonumber(arg[1])
local replyCh = tonumber(arg[2])
local floors
if arg[3] then
    floors = arg[3]
end

local isHome = true
local modem = peripheral.wrap("left")
modem.open(replyCh)

while true do
    print("What floor would you like to go to?")
    
    if floors then
        for _, flr in floors do
            print(flr)
        end
    end

    local input = read()
    term.clear()
    print("Searching for floor '"..input.."' ...")
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
                print("Found floor '"..input.."' !")
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