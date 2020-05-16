--[[META
{
system = "CraftOS",
version = {0,0}, 
type = "macisk",
name = "download",
description = {
	en = "Downloader"
	da = ""
	}
}
]]


local args = {...}
dk.import("file")
dk.import("serialize")

-- # Program Code # --
local download = {}
----------------------


--downloads string
function download.getString(url)
    dk.console.print("[status:]" , "downloading...")
    local response = http.get(url)
    if response then
        local responseString = response.readAll()
        response.close()
		dk.console.print("[status:]" , "downloaded")
		return responseString
    else
        dk.console.print("[warning:]" , "could not download")
        return nil
    end
end

--downloads table
function download.getTable(url)
	local driveString = download.getString(url)
	if driveString ~= nil then
		local t = serialize.stringToTable(driveString)
		return t
	else
		return nil
	end
end

--downloads file
function download.save(url,path)
	local driveString = download.getString(url)
	if driveString == nil then
		dk.console.print("[warning:]" , "file could not be saved")
		return nil
	end
	file.saveString(driveString,path)
	dk.console.print("[status:]" , "file saved")
	return true
end

download.url = {}

--creates download link for google drive
function download.url.googleDrive (id) 
	return "https://drive.google.com/uc?id="..id.."&export=download"
end
	
function download.url.pastebin (id) 
	return "http://pastebin.com/raw.php?i="..id
end


download.dkmv = {}

function download.dkmv.update()
	download.save(download.url.googleDrive("1QM0NJOTIcijmoc2MZfk0I2L_A7jfou8p"), dk.path.data .. "/dkmv.db")
end


-----------------------
function download.runConsole (args)
	
	if args[1] == "save" then
		download.save(args[2],args[3])
		return
	end
	if args[1] == "dkmv" then
		download.dkmv.update()
		return
	end
	
	dk.console.print("[warning:]","this program has no functionality")
end
----------------------
if args[1] == "-l" then 
	return download
else
	download.runConsole(args)
	return
end