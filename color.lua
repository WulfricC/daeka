--[[META
{
system = "CraftOS",
version = {0,0}, 
type = "macisk",
name = "color",
description = {
	en = "API for color"
	da = ""
	}
}
]]

local args = {...}

-- # Program Code # --
local color = {}
----------------------
color.white = 1
color.orange = 2
color.magenta = 4
color.lightBlue = 8
color.yellow = 16
color.lime = 32
color.pink = 64
color.gray = 128
color.lightGray = 256
color.cyan = 512
color.purple = 1024
color.blue = 2048
color.brown = 4096
color.green = 8192
color.red = 16384
color.black = 32768
 
function color.combine( ... )
    local r = 0
    for n,c in ipairs( { ... } ) do
        r = bit32.bor(r,c)
    end
    return r
end
 
function color.subtract( colors, ... )
    local r = colors
    for n,c in ipairs( { ... } ) do
        r = bit32.band(r, bit32.bnot(c))
    end
    return r
end
 
function color.test( colors, color )
    return ((bit32.band(colors, color)) == color)
end

function color.letterCode(number)
	local letters = {}
		letters[1] = "0"
		letters[2] = "1"
		letters[4] = "2"
		letters[8] = "3"
		letters[16] = "4"
		letters[32] = "5"
		letters[64] = "6"
		letters[128] = "7"
		letters[256] = "8"
		letters[512] = "9"
		letters[1024] = "a"
		letters[2048] = "b"
		letters[4096] = "c"
		letters[8192] = "d"
		letters[16384] = "e"
		letters[32768] = "f"
	local returnand = letters[number]
	if returnand == nil then
		returnand = "a"
	end
	return returnand
end

function color.runConsole (args)
	dk.console.print("[warning:]" , "color is not a program which can be run")
end

----------------------
if args[1] == "-l" then 
	return color
else
	color.runConsole(args)
	return
end