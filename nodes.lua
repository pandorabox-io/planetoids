local base_stone_tile = "default_stone.png^[multiply:#aaaaeeff"

minetest.register_node("planetoids:stone", {
  description = "Planetoid stone",
  tiles = {
    base_stone_tile
  },
  groups = {
    cracky = 2
  },
  drop = 'default:cobble',
  sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("planetoids:stone_with_coal", {
	description = "Coal Ore",
	tiles = {
    base_stone_tile .. "^default_mineral_coal.png"
  },
	groups = {
    cracky = 3
  },
	drop = 'default:coal_lump',
	sounds = default.node_sound_stone_defaults(),
})
