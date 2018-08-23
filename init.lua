
planetoids = {
	miny = tonumber(minetest.settings:get("planetoids.miny")) or 6000,
	maxy = tonumber(minetest.settings:get("planetoids.maxy")) or 10000,
	debug = minetest.settings:get("planetoids.debug") or false
}


local MP = minetest.get_modpath("planetoids")

dofile(MP.."/mapgen.lua")

print("[OK] Planetoids")



