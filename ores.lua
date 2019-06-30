local has_technic_mod = minetest.get_modpath("technic")


minetest.register_ore({
	ore_type       = "scatter",
	ore            = "default:stone_with_iron",
	wherein        = "default:stone",
	clust_scarcity = 24 * 24 * 24,
	clust_num_ores = 62,
	clust_size     = 12,
	y_max          = planetoids.maxy,
	y_min          = planetoids.miny,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "default:stone_with_gold",
	wherein        = "default:stone",
	clust_scarcity = 24 * 24 * 24,
	clust_num_ores = 27,
	clust_size     = 6,
	y_max          = planetoids.maxy,
	y_min          = planetoids.miny,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "default:stone_with_mese",
	wherein        = "default:stone",
	clust_scarcity = 24 * 24 * 24,
	clust_num_ores = 27,
	clust_size     = 6,
	y_max          = planetoids.maxy,
	y_min          = planetoids.miny,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "default:stone_with_diamond",
	wherein        = "default:stone",
	clust_scarcity = 24 * 24 * 24,
	clust_num_ores = 27,
	clust_size     = 6,
	y_max          = planetoids.maxy,
	y_min          = planetoids.miny,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "default:mese",
	wherein        = "default:stone",
	clust_scarcity = 24 * 24 * 24,
	clust_num_ores = 27,
	clust_size     = 6,
	y_max          = planetoids.maxy,
	y_min          = planetoids.miny,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "planetoids:radioactive_stone",
	wherein        = "default:stone",
	clust_scarcity = 8 * 8 * 8,
	clust_num_ores = 9,
	clust_size     = 3,
	y_max          = planetoids.maxy,
	y_min          = planetoids.miny,
})


