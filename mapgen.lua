
minetest.register_on_generated(function(minp, maxp, seed)

	-- default from 6k to 10k
	if minp.y < planetoids.miny or minp.y > planetoids.maxy then
		return
	end

	local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
	local area = VoxelArea:new{MinEdge=emin, MaxEdge=emax}

  planetoids.mapgen_oreplanet(minp, maxp, vm, area)


	vm:write_to_map()

end)
