local has_technic_mod = minetest.get_modpath("technic")

local clust_scarcity = 24 * 24 * 10
local clust_num_ores = 27
local clust_size = 10


minetest.register_ore({
	ore_type       = "scatter",
	ore            = "default:stone_with_iron",
	wherein        = "default:stone",
	clust_scarcity = clust_scarcity,
	clust_num_ores = clust_num_ores,
	clust_size     = clust_size,
	y_max          = planetoids.maxy,
	y_min          = planetoids.miny,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "default:stone_with_gold",
	wherein        = "default:stone",
	clust_scarcity = clust_scarcity,
	clust_num_ores = clust_num_ores,
	clust_size     = clust_size,
	y_max          = planetoids.maxy,
	y_min          = planetoids.miny,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "default:stone_with_mese",
	wherein        = "default:stone",
	clust_scarcity = clust_scarcity,
	clust_num_ores = clust_num_ores,
	clust_size     = clust_size,
	y_max          = planetoids.maxy,
	y_min          = planetoids.miny,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "default:stone_with_diamond",
	wherein        = "default:stone",
	clust_scarcity = clust_scarcity,
	clust_num_ores = clust_num_ores,
	clust_size     = clust_size,
	y_max          = planetoids.maxy,
	y_min          = planetoids.miny,
})


minetest.register_ore({
	ore_type       = "scatter",
	ore            = "planetoids:radioactive_stone",
	wherein        = "default:stone",
	clust_scarcity = clust_scarcity,
	clust_num_ores = clust_num_ores,
	clust_size     = clust_size,
	y_max          = planetoids.maxy,
	y_min          = planetoids.miny,
})


