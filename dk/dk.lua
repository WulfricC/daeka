--[[META
{
system = "CraftOS",
version = {0,0}, 
type = "topmystisk",
name = "dk",
description = {
	en = "The core DK commands"
	da = ""
	}
}
]]

--[[
dk holds key variables for use within dk based programs
]]

local args = {...}

-- # Program Code # --
local dk = {}
----------------------

dk.console = {}
dk.console.print = print

--[[dk.path = {
    root = "dk",
	program = "dk/mystisk",
	data = "dk/iskcaest",
	config = "dk/dta/config.db"
    }]]
dk.path = {
    root = "",
	program = "",
	data = "",
	config = ""
    }
	
dk.imported = {}
function dk.import(name)
	local function _import(filePath)
		if dk.imported[filePath] == nil then
			dk.imported[filePath] = {}
			local library = assert(loadfile(filePath))("-l")
			for k,v in pairs(library) do
				dk.imported[filePath][k] = v
			end
			return dk.imported[filePath]
		else
			return dk.imported[filePath]
		end
	end
	if fs.exists(dk.path.program.."/"..name) then
		return _import(dk.path.program.."/"..name)
	elseif fs.exists(dk.path.program.."/"..name..".lua") then
		return _import(dk.path.program.."/"..name..".lua")
	else
		 dk.console.print("[warning:]", "'"..name.."' not found")
		return nil
	end
end


function dk.runConsole (args)
	_G.dk = dk
	dk.console.print("[status:]", "dk loaded into _G")
end

----------------------
if args[1] == "-l" then 
	return dk
else
	dk.runConsole(args)
	return
end
