--[[META
{
system = "CraftOS",
version = {0,0}, 
type = "macisk",
name = "file",
description = {
	en = "File Handling"
	da = ""
	}
}
]]

local args = {...}
local serialize = dk.import("serialize")

-- # Program Code # --

----------------------
local file = {}

--check if file exists and is a file
function file.exists(path)						
	if fs.exists(path) and not fs.isDir(path) then
		return true
	else
		return false
	end
end

--check if a file is readonly
function file.isReadOnly(path)
	return fs.isReadOnly(path)
end
	
--extract metadata stored as a lua table
function file.loadMetadata(path)
	local startof = "--[[META"
	local endof = "]]"
	if not file.exists(path) then
		dk.console.print("[warning:]","file '"..path.."' does not exist")
		return nil
	end
	local hFile = fs.open(path,"r")
	local line = ""
	local metaDataString = ""
	repeat
        line = hFile.readLine()
	until string.find(line,startof)
	metaDataString = metaDataString..line
	repeat 
		if string.find(line,endof)then
			break
		elseif line == nil then
			dk.console.print("[warning:]","no metadata found in file")
		else
			metaDataString = metaDataString..line.."\n"
		end
		line = hFile.readLine()
	until false
	metaDataString = string.gsub(metaDataString,".*"..startof, "")
	metaDataString = string.gsub(metaDataString,endof..".*", "")
	local metaDataTable = serialize.stringToTable(metaDataString)
	hFile.close()
	return metaDataTable
end

--load entire file as a string
function file.loadString(path)
	if not file.exists(path) then
			dk.console.print("[warning:]","file '"..path.."' does not exist")
		return nil
	end
	local hFile = fs.open(path,"r")
	local str = hFile.readAll()
	hFile.close()
	if str == nil then
			dk.console.print("[warning:]","file could not be read")
		return nil
	else
		return str
	end
end

--load entire file as a table
function file.loadTable(path)
	local str = file.loadString(path)
	return serialize.stringToTable(str)
end

--save a string to a file
function file.saveString(str,path)
	if file.isReadOnly(path) then
		dk.console.print("[warning:]","file '"..path.."' is read only")
		return nil
	end
	if file.exists(path) then
		dk.console.print("[warning:]","file '"..path.."' is being overwritten")
	else
		dk.console.print("[warning:]","file '"..path.."' is being created")
	end
	local hFile = fs.open(path,"w")
	hFile.write(str)
	hFile.close()
	return true
end

--save a table to a file
function file.saveTable(t,path)
	local str = serialize.tableToString(t)
	return file.saveString(str)
end

--save metadata to a file (highly inneficient!)
function file.saveMetadata(startof,endof,t,path)
	local oldFileStr = file.loadString(path)
	if oldFileStr == nil then
		return nil
	end
	local preMeta = string.gsub(oldFileStr,startof..".*", "")
	local postMeta = string.gsub(oldFileStr,".*"..endof,"")
	local newFileStr = preMeta..startof..string.gsub(serialize.tableToString(t),"\n","")..endof..postMeta
	file.saveString(newFileStr,path)
	return true
end

--# file manipulation #--

--delete a file
function file.delete(path)
	if not file.exists(path) then
		dk.console.print("[warning:]","file '"..path.."' does not exist")
		return nil
	end
	if file.isReadOnly(path) then
		dk.console.print("[warning:]","file '"..path.."' is read only")
		return nil
	end
	fs.delete(path)
	return true
end

--create a new file
function file.create(path)
	if file.exists(path) then
		dk.console.print("[warning:]","file '"..path.."' in being replaced")
	end	
	local hFile = fs.open(path,"w")
	if hFile == nil then
		dk.console.print("[warning:]","file '"..path.."' could not be created")
		return nil
	end
	fs.close()
	return true

end

function file.runConsole (args)
	dk.console.print("[warning:]","this program has no functionality")
end

----------------------
if args[1] == "-l" then 
	return file
else
	file.runConsole(args)
	return
end