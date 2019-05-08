

local has_vacuum_mod = minetest.get_modpath("vacuum")


minetest.register_on_generated(function(minp, maxp, seed)

	-- default from 6k to 10k
	if minp.y < planetoids.miny or minp.y > planetoids.maxy then
		return
	end

	if has_vacuum_mod and not vacuum.is_mapgen_block_in_space(minp, maxp) then
		-- no vacuum there, don't generate planetoids in non-vacuum
		return
	end


	local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
	local area = VoxelArea:new{MinEdge=emin, MaxEdge=emax}

  planetoids.mapgen_oreplanet(minp, maxp, vm, area)


	vm:write_to_map()

end)
