-- wget https://raw.githubusercontent.com/Preassume/MC-Lua/main/lua-scripts/elevatorScripts/getElevatorScripts.lua getElevatorScripts
-- Use the above command on a minecraft computer to get this program.
-- Run this program to automatically gather all other elevator scripts.

local baseURL = "https://raw.githubusercontent.com/Preassume/MC-Lua/main/lua-scripts/"

function getScript(url, fileName)
    local cacheBreak = tostring(math.random(0, 99999))
    
    url = url.."?breaker="..cacheBreak
    
    local res, err = http.get(url)
    if not res then error(err..'\n'..fileName..'\n'..url) end
    
    if fs.exists(fileName) then fs.delete(fileName) end
    
    shell.run("wget", url, fileName)
end

getScript("https://raw.githubusercontent.com/Preassume/MC-Lua/main/lua-scripts/elevatorScripts/elevatorScriptLocations.lua", "elevatorScriptLocations")

local scripts = require("elevatorScriptLocations")

for fn, dir in pairs(scripts) do
    local url = baseURL..dir
    getScript(url, fn)
end
