-- shell.run("elevatorCaller.lua", "protocol", "floorName")

local args = {...}

local protocol = args[1] or error("Error: No protocol was given.")

local floorName = args[2] or error("Error: No floor name was given.")

peripheral.find("modem", rednet.open)

local responseTable = {
	[0] = "No response from controller. Perhaps it's busy. Try again in a moment.",
	[37] = "I've been told that the elevator is already here.",
	[38] = "The elevator seems to be busy now. Try again in a moment.",
	[39] = "The controller doesn't recognize this floor. Perhaps it was entered incorrectly on setup?",
}

local function callElevator()
	rednet.broadcast(floorName, protocol)
	local id, msg = rednet.receive(protocol, 1)
	if not msg then
		id, msg = rednet.receive(protocol, 1)
	end
	if not msg then
		return 0
	end
	
	if msg == 37 or msg == 38 or msg == 39 then
		return msg
	end
end

local function clearScrn()
    term.clear()
    term.setCursorPos(1, 1)
end

local function getKey()
	local event, key = os.pullEvent("key_up")
	return key == keys.enter
end

while true do
	clearScrn()
	print("Press the 'enter' key to call the elevator.")
	if getKey() then
		clearScrn()
		print("Calling elevator...\n")
		local msg = callElevator()
		if msg then
			print(responseTable[msg])
			print("\nPress any key to continue...")
			getKey()
		end
	end
end