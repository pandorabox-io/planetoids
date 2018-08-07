

minetest.register_on_dignode(function(pos, oldnode, digger)
	local np = minetest.find_node_near(pos, 1, {"planetoids:atmosphere"})
	if np ~= nil then
		-- preserve atmosphere
		-- TODO: check count: >=2 -> preserve
		minetest.set_node(pos, {name = "planetoids:atmosphere"})
		return
	end
end)
