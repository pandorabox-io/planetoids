local has_vacuum_mod = minetest.get_modpath("vacuum")
local has_loot_mod = minetest.get_modpath("loot")


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

if has_loot_mod then
	c_loot_node = minetest.get_content_id("loot:loot_node")
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
	id = minetest.get_content_id("default:stone_with_mese"),
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
	id = minetest.get_content_id("default:ice"),
	chance = 0.9
})

register_ore({
	id = minetest.get_content_id("default:stone"),
	chance = 0.85
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

	if count == 0 and has_loot_mod then
		-- empty space, add loot chance if available
		if math.random(10) == 1 then
			local pos = {
				x=math.random(minp.x,maxp.x),
				y=math.random(minp.y,maxp.y),
				z=math.random(minp.z,maxp.z)
			}

			local index = area:index(pos.x,pos.y,pos.z)
			data[index] = c_loot_node
			if planetoids.debug then
				print("[Planetoids] generated loot node @ " .. minetest.pos_to_string(pos))
			end
		end
	end

	if planetoids.debug then
		print("[Planetoids] count: " .. count .. " min: " .. min_perlin .. " max: " .. max_perlin)
	end

	vm:set_data(data)
	vm:write_to_map()

end)
