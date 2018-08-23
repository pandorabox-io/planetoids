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
local c_vacuum

if has_vacuum_mod then
	c_vacuum = minetest.get_content_id("vacuum:vacuum")
end


local ores = {}
local min_chance = 1

local register_ore = function(def)
	table.insert(ores, def)
	min_chance = math.min(def.chance, min_chance)
end

register_ore({
	id = minetest.get_content_id("default:lava_source"),
	chance = 1.16
})

register_ore({
	id = minetest.get_content_id("default:goldblock"),
	chance = 1.15
})

register_ore({
	id = minetest.get_content_id("default:diamondblock"),
	chance = 1.12
})

register_ore({
	id = minetest.get_content_id("default:steelblock"),
	chance = 1.1
})

register_ore({
	id = minetest.get_content_id("default:stone_with_iron"),
	chance = 1.0
})

register_ore({
	id = minetest.get_content_id("default:stone_with_gold"),
	chance = 0.99
})

register_ore({
	id = minetest.get_content_id("default:stone_with_copper"),
	chance = 0.98
})

register_ore({
	id = minetest.get_content_id("default:stone"),
	chance = 0.8
})


-- sort ores
table.sort(ores, function(a,b)
	return b.chance < a.chance
end)

minetest.register_on_generated(function(minp, maxp, seed)

	-- default from 6k to 10k
	if minp.y < planetoids.miny or minp.y > planetoids.maxy then
		return
	end

	local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
	local area = VoxelArea:new{MinEdge=emin, MaxEdge=emax}
	local data = vm:get_data()
	local min_perlin = 10
	local max_perlin = 0

	local side_length = maxp.x - minp.x + 1 -- 80
	local map_lengths_xyz = {x=side_length, y=side_length, z=side_length}

	local planet_perlin_map = minetest.get_perlin_map(planet_params, map_lengths_xyz):get3dMap_flat(minp)

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

			if planet_n > min_chance then
				
				-- planet
				data[index] = c_base
				for _,ore in pairs(ores) do
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

	if planetoids.debug then
		print("[Planetoids] count: " .. count .. " min: " .. min_perlin .. " max: " .. max_perlin)
	end

	vm:set_data(data)
	vm:write_to_map()

end)
