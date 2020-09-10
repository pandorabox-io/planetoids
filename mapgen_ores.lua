
local clust_scarcity = 24 * 24 * 24
local clust_num_ores = 27
local clust_size = 10


minetest.register_ore({
	ore_type       = "scatter",
	ore            = "planetoids:stone_with_coal",
	wherein        = "planetoids:stone",
	clust_scarcity = clust_scarcity,
	clust_num_ores = clust_num_ores,
	clust_size     = clust_size,
	y_max          = planetoids.maxy,
	y_min          = planetoids.miny
})