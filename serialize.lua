--[[META
{
system = "CraftOS",
version = {0,0}, 
type = "macisk",
name = "example",
description = {
	en = "An example program for the framework of a dk program"
	da = ""
	}
}
]]

local args = {...}

-- # Program Code # --
local serialize = {}
----------------------

--convert string to table
function serialize.stringToTable(str)
	local t = textutils.unserialize(str)
	if t == nil then
		dk.console.print("[warning:]" , "unable to parse string to table")
		return nil
	else
		return t
	end
end

--convert table to string
function serialize.tableToString(t)
	local str = textutils.serialize(t)
	return str
end

----------------------

function serialize.runConsole (args)
	dk.console.print("[warning:]","this program has no functionality")
end

----------------------
if args[1] == "-l" then 
	return serialize
else
	serialize.runConsole(args)
	return
end