if minetest.get_modpath("vacuum") then

	-- replace stone in no-space zones
	minetest.register_lbm({
		name = "planetoids:radioactive_stone_replace",
		nodenames = {"planetoids:radioactive_stone"},
		-- run_at_every_load = true,
		action = function(pos, node)
			if not vacuum.is_pos_in_space(pos) then
				node.name = "default:stone"
				minetest.swap_node(pos, node)
			end
		end
	})
end
