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



local planet_perlin

local planet_perlin_map = {}

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
			-- TODO: add casing around node
			-- door with trap obsidian glass https://github.com/minetest-mods/moreblocks/blob/master/nodes.lua#L317
			-- casing with https://wiki.minetest.net/Steel_Block
			-- uranium block under loot chest https://github.com/minetest-mods/technic/blob/c93bfefd9fb66cab4a766b4e6a4d361a85503685/technic_worldgen/nodes.lua#L73
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
