
planetoids = {
	miny = tonumber(minetest.settings:get("planetoids.miny")) or 6000,
	maxy = tonumber(minetest.settings:get("planetoids.maxy")) or 10000,
	debug = minetest.settings:get("planetoids.debug") or false,
	min_chance = 0.85,
}


local MP = minetest.get_modpath("planetoids")

dofile(MP.."/stone.lua")
dofile(MP.."/ores.lua")
dofile(MP.."/mapgen_oreplanet.lua")
dofile(MP.."/mapgen.lua")
dofile(MP.."/lbm.lua")

print("[OK] Planetoids")
