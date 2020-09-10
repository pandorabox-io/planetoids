
planetoids = {
	miny = tonumber(minetest.settings:get("planetoids.miny")) or 6000,
	maxy = tonumber(minetest.settings:get("planetoids.maxy")) or 10000,
	debug = minetest.settings:get("planetoids.debug") or false,
	min_chance = 0.85,
	ores = {}
}


local MP = minetest.get_modpath("planetoids")

dofile(MP.."/legacy.lua")
dofile(MP.."/nodes.lua")
dofile(MP.."/mapgen_ores.lua")
dofile(MP.."/ores.lua")
dofile(MP.."/mapgen_oreplanet.lua")
dofile(MP.."/mapgen.lua")

print("[OK] Planetoids")
