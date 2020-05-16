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
local program = {}
----------------------

function program.runConsole (args)
	dk.console.print("[warning:]","this program is an example which does nothing")
end

----------------------
if args[1] == "-l" then 
	return program
else
	program.runConsole(args)
	return
end