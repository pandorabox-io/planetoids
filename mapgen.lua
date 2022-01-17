local has_vacuum_mod = minetest.get_modpath("vacuum")
local has_planetoidgen_mod = minetest.get_modpath("planetoidgen")


local get_corners = function(minp, maxp)
	return {
		minp,
		maxp,
		{ x=maxp.x, y=minp.y, z=minp.z },
		{ x=minp.x, y=maxp.y, z=minp.z },
		{ x=minp.x, y=minp.y, z=maxp.z },
		{ x=maxp.x, y=maxp.y, z=minp.z },
		{ x=minp.x, y=maxp.y, z=maxp.z },
		{ x=maxp.x, y=minp.y, z=maxp.z },
	}
end

local check_corners_in_space = function(minp, maxp)
	for _, pos in ipairs(get_corners(minp, maxp)) do
		if vacuum.is_pos_in_space(pos) then
			return true
		end
	end

	return false
end


minetest.register_on_generated(function(minp, maxp)

	-- default from 6k to 10k
	if minp.y < planetoids.miny or minp.y > planetoids.maxy then
		return
	end

	if has_vacuum_mod and not check_corners_in_space(minp, maxp) then
		-- no vacuum there, don't generate planetoids in non-vacuum
		return
	end

	if has_planetoidgen_mod and type(planetoidgen.is_occupied) == "function" and planetoidgen.is_occupied(minp) then
		-- here be planetoids, skip mapgen
		return
	end


	local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
	local area = VoxelArea:new{MinEdge=emin, MaxEdge=emax}

	planetoids.mapgen_oreplanet(minp, maxp, vm, area)


	vm:write_to_map()

end)
