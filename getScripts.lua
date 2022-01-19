local baseURL = "https://raw.githubusercontent.com/Preassume/MC-Lua/main/lua-scripts/"

local scripts = {
    ["commonAPI"] = "commonAPI.lua",
    ["autoAcacia"] = "treeFarming/autoAcacia.lua",
    ["autoFarm"] = "cropFarming/autoFarm.lua",
}

function getScript(url, fileName)
    local cacheBreak = tostring(math.random(0, 99999))
    
    url = url.."?breaker="..cacheBreak
    
    local res, err = http.get(url)
    if not res then error(err) end
    
    if fs.exists(fileName) then fs.delete(fileName) end
    
    shell.run("wget", url, fileName)
end

for fn, dir in pairs(scripts) do
    local url = baseURL..dir
    getScript(url, fn)
end
