-- startup

--[[META
{
system = "CraftOS",
version = {0,0}, 
type = "topmystisk",
name = "dkos",
description = {
	en = "The core DK runner program"
	da = ""
	}
}
]]

--[[
The startup program is the core program for 
running dk.  It launches the other programs to run.
]]

-- first task at boot is to find the dk script and run it

_G.dk = loadfile("dk.lua")("-l")