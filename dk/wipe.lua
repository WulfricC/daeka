--[[META
{
system = "CraftOS",
version = {0,0}, 
type = "macisk",
name = "wipe",
description = {
	en = "This program wipes the system"
	da = ""
	}
}
]]

local args = {...}

-- # Program Code # --
local program = {}
----------------------

function program.runConsole (args)
	for _,file in ipairs(fs.list("/")) do
	  if not fs.isReadOnly(file) then
		fs.delete(file)
	  end
	end
end

----------------------
if args[1] == "-l" then 
	return program
else
	program.runConsole(args)
	return
end