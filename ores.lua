
local register_ore = function(def)
	table.insert(planetoids.ores, def)
	planetoids.min_chance = math.min(def.chance, planetoids.min_chance)
end

register_ore({
	id = minetest.get_content_id("default:lava_source"),
	chance = 1.16
})

register_ore({
	id_list = {
		minetest.get_content_id("default:stone_with_mese"),
		minetest.get_content_id("default:stone_with_copper"),
		minetest.get_content_id("default:stone_with_iron"),
	},
	chance = 1.0
})

register_ore({
	id_list = {
		minetest.get_content_id("default:stone_with_iron"),
		minetest.get_content_id("default:stone_with_gold"),
		minetest.get_content_id("default:stone_with_copper"),
	},
	chance = 0.98
})

register_ore({
	id = minetest.get_content_id("default:ice"),
	chance = 0.9
})

register_ore({
	id = minetest.get_content_id("default:stone"),
	chance = 0.85
})


-- sort ores
table.sort(planetoids.ores, function(a,b)
	return b.chance < a.chance
end)
