local has_vacuum_mod = minetest.get_modpath("vacuum")

-- http://dev.minetest.net/PerlinNoiseMap

-- basic planet noise
local planet_params = {
   offset = 0,
   scale = 1,
   spread = {x=128, y=64, z=128},
   seed = 3454657,
   octaves = 4,
   persist = 0.6
}

local c_base = minetest.get_content_id("default:stone")
local c_air = minetest.get_content_id("air")
local c_ignore = minetest.get_content_id("ignore")
local c_vacuum

local ores = {}
local min_chance = 1

local register_ore = function(def)
	table.insert(ores, def)
	min_chance = math.min(def.chance, min_chance)
end

if has_vacuum_mod then

	c_vacuum = minetest.get_content_id("vacuum:vacuum")
	register_ore({
		id = c_vacuum,
		chance = 1
	})

else
	register_ore({
		id = minetest.get_content_id("air"),
		chance = 1
	})
end

register_ore({
	id = minetest.get_content_id("default:stone_with_diamond"),
	chance = 0.998
})

register_ore({
	id = minetest.get_content_id("default:stone_with_mese"),
	chance = 0.995
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
	id = minetest.get_content_id("default:stone_with_iron"),
	chance = 0.9
})

register_ore({
	id = minetest.get_content_id("default:stone_with_coal"),
	chance = 0.8
})

register_ore({
	id = minetest.get_content_id("default:ice"),
	chance = 0.45
})

-- sort ores
table.sort(ores, function(a,b)
	return b.chance < a.chance
end)

minetest.register_on_generated(function(minp, maxp, seed)

	-- TODO: config height
	if minp.y < 6000 or minp.y > 10000 then
		return
	end

	local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
	local area = VoxelArea:new{MinEdge=emin, MaxEdge=emax}
	local data = vm:get_data()

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

	--if count > 0 then
		-- print("Count: " .. count)
	--end

	vm:set_data(data)
	vm:write_to_map()

end)


print("[OK] planetoids")
