
planetoids = {
	miny = tonumber(minetest.settings:get("planetoids.miny")) or 6000,
	maxy = tonumber(minetest.settings:get("planetoids.maxy")) or 10000,
	debug = minetest.settings:get("planetoids.debug") or false,
	min_chance = 1,
	ores = {}
}


local MP = minetest.get_modpath("planetoids")

dofile(MP.."/ores.lua")
dofile(MP.."/mapgen.lua")

print("[OK] Planetoids")
