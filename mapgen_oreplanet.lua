local has_vacuum_mod = minetest.get_modpath("vacuum")


-- http://dev.minetest.net/PerlinNoiseMap

-- basic planet noise
local planet_params = {
   offset = 0,
   scale = 1,
   spread = {x=2000, y=200, z=2000},
   seed = 345465738,
   octaves = 3,
   persist = 0.6
}


local c_base = minetest.get_content_id("default:stone")
local c_air = minetest.get_content_id("air")
local c_ignore = minetest.get_content_id("ignore")
local c_loot_node
local c_vacuum

if has_vacuum_mod then
	c_vacuum = minetest.get_content_id("vacuum:vacuum")
end

local planet_perlin

local planet_perlin_map = {}


planetoids.mapgen_oreplanet = function(minp, maxp, vm, area)

  	local data = vm:get_data()
  	local min_perlin = 10
  	local max_perlin = 0

  	local side_length = maxp.x - minp.x + 1 -- 80
  	local map_lengths_xyz = {x=side_length, y=side_length, z=side_length}

  	planet_perlin = planet_perlin or minetest.get_perlin_map(planet_params, map_lengths_xyz)
  	planet_perlin:get_3d_map_flat(minp, planet_perlin_map)

  	local i = 1
  	local count = 0
  	for z=minp.z,maxp.z do
  	for y=minp.y,maxp.y do
  	for x=minp.x,maxp.x do

  		local index = area:index(x,y,z)

  		if data[index] == c_air or data[index] == c_vacuum or data[index] == c_ignore then
  			-- unpopulated node

  			local planet_n = planet_perlin_map[i]

  			if planet_n > max_perlin then max_perlin = planet_n end
  			if planet_n < min_perlin then min_perlin = planet_n end

  			if planet_n > planetoids.min_chance then

  				-- planet
  				data[index] = c_base
  				for _,ore in pairs(planetoids.ores) do
  					if planet_n > ore.chance then
  						data[index] = ore.id
  						count = count + 1
  						break
  					end
  				end
  			end
  		end

  		i = i + 1

  	end --x
  	end --y
  	end --z

    vm:set_data(data)

  	if planetoids.debug then
  		print("[Planetoids] count: " .. count .. " min: " .. min_perlin .. " max: " .. max_perlin)
  	end
end
