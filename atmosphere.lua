
minetest.register_node("planetoids:atmosphere", {
	description = "Planetoid atmosphere",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	drawtype = "glasslike",
	post_effect_color = {a = 50, r = 150, g = 150, b = 150},
	tiles = {"vacuum_air.png^[colorize:#E0E0E033"},
	alpha = 0.2,
	groups = {not_in_creative_inventory=1},
	paramtype = "light",
	sunlight_propagates = true
})

