local STATE = {}

STATE.StateEnum = {
	Player = {
		MaxEnergy = "player_max_energy",
		CurrentEnergy = "player_current_energy",
		MaxSpeed = "player_max_speed",
		MiningDamage = "player_mining_damage",
		CurrentHealth = "player_current_health",
		MaxHealth = "player_max_health",
		Coins = "player_coins",
		BeltItems = {},
		SelectedTool = ""
	},
	Inventory = {
		Row = "inventory_size_row",
		Col = "inventory_size_col",
		MaxWeight = "inventory_max_weight",
		MaxItems = "inventory_max_items",
		Weight = "inventory_weight",
		Items = {
			Resources = "inventory_items_resources"
		},
		Type = "type"
	},
	Level = {
		Tiles = "level_tiles",
		MouseOverTileHash = "level_mouse_over_tile",
		TileType = "level_tile_type",
		TileSize = "settings_tile_size",
		MaxRoundTimeSeconds = "settings_max_round_time_seconds"
	},
	Physics = {
		Gravity = "physics_gravity"
	},
	Settings = {
		FullScreen = "full_screen"
	}
}

STATE.InventoryTypeEnum = {
	POUCH = 0,
}

STATE.TileTypeEnum = {
	EMPTY = 0,
	DIRT = 1,
	IRON_ORE = 2,
	GOLD_ORE = 3,
}

STATE.TileTypeToHitpoints = {
	[STATE.TileTypeEnum.EMPTY] = 0,
	[STATE.TileTypeEnum.DIRT] = 100,
	[STATE.TileTypeEnum.IRON_ORE] = 150,
	[STATE.TileTypeEnum.GOLD_ORE] = 200,
}

STATE.ReverseTileTypeEnum = {
	[0] = "EMPTY",
	[1] = "DIRT",
	[2] = "IRON_ORE",
	[3] = "GOLD_ORE",
}

STATE.TileSpriteAnimations = {
	["0000-01"] = "dirt-all",
	["0000-01-c1"] = "dirt-all-crack-1",
	["0000-01-c2"] = "dirt-all-crack-2",
	["0000-01-c3"] = "dirt-all-crack-3",
	["~0000-01"] = "dirt-all-grass",
	["~0000-01-c1"] = "dirt-all-crack-1-grass",
	["~0000-01-c2"] = "dirt-all-crack-2-grass",
	["~0000-01-c3"] = "dirt-all-crack-3-grass",
	["1000-01"] = "dirt-right-bottom-left",
	["1000-01-c1"] = "dirt-right-bottom-left-crack-1",
	["1000-01-c2"] = "dirt-right-bottom-left-crack-2",
	["1000-01-c3"] = "dirt-right-bottom-left-crack-3",
	["~1000-01"] = "dirt-all-grass",
	["~1000-01-c1"] = "dirt-all-crack-1-grass",
	["~1000-01-c2"] = "dirt-all-crack-2-grass",
	["~1000-01-c3"] = "dirt-all-crack-3-grass",
	["1010-01"] = "dirt-right-left",
	["1010-01-c1"] = "dirt-right-left-crack-1",
	["1010-01-c2"] = "dirt-right-left-crack-2",
	["1010-01-c3"] = "dirt-right-left-crack-3",
	["~1010-01"] = "dirt-right-left-grass",
	["~1010-01-c1"] = "dirt-right-left-crack-1-grass",
	["~1010-01-c2"] = "dirt-right-left-crack-2-grass",
	["~1010-01-c3"] = "dirt-right-left-crack-3-grass",
	["0100-01"] = "dirt-top-bottom-left",
	["0100-01-c1"] = "dirt-top-bottom-left-crack-1",
	["0100-01-c2"] = "dirt-top-bottom-left-crack-2",
	["0100-01-c3"] = "dirt-top-bottom-left-crack-3",
	["0101-01"] = "dirt-top-bottom",
	["0101-01-c1"] = "dirt-top-bottom-crack-1",
	["0101-01-c2"] = "dirt-top-bottom-crack-2",
	["0101-01-c3"] = "dirt-top-bottom-crack-3",
	["0001-01"] = "dirt-top-right-bottom",
	["0001-01-c1"] = "dirt-top-right-bottom-crack-1",
	["0001-01-c2"] = "dirt-top-right-bottom-crack-2",
	["0001-01-c3"] = "dirt-top-right-bottom-crack-3",
	["0110-01"] = "dirt-top-left",
	["0111-01"] = "dirt-top",
	["0011-01"] = "dirt-top-right",
	["0110-01-c1"] = "dirt-top-left-crack-1",
	["0111-01-c1"] = "dirt-top-crack-1",
	["0011-01-c1"] = "dirt-top-right-crack-1",
	["0110-01-c2"] = "dirt-top-left-crack-2",
	["0111-01-c2"] = "dirt-top-crack-2",
	["0011-01-c2"] = "dirt-top-right-crack-2",
	["0110-01-c3"] = "dirt-top-left-crack-3",
	["0111-01-c3"] = "dirt-top-crack-3",
	["0011-01-c3"] = "dirt-top-right-crack-3",
	["~0110-01"] = "dirt-top-left-grass",
	["~0111-01"] = "dirt-top-grass",
	["~0011-01"] = "dirt-top-right-grass",
	["~0110-01-c1"] = "dirt-top-left-crack-1-grass",
	["~0111-01-c1"] = "dirt-top-crack-1-grass",
	["~0011-01-c1"] = "dirt-top-right-crack-1-grass",
	["~0110-01-c2"] = "dirt-top-left-crack-2-grass",
	["~0111-01-c2"] = "dirt-top-crack-2-grass",
	["~0011-01-c2"] = "dirt-top-right-crack-2-grass",
	["~0110-01-c3"] = "dirt-top-left-crack-3-grass",
	["~0111-01-c3"] = "dirt-top-crack-3-grass",
	["~0011-01-c3"] = "dirt-top-right-crack-3-grass",
	["1110-01"] = "dirt-left",
	["1111-01"] = "dirt",
	["1011-01"] = "dirt-right",
	["1110-01-c1"] = "dirt-left-crack-1",
	["1111-01-c1"] = "dirt-crack-1",
	["1011-01-c1"] = "dirt-right-crack-1",
	["1110-01-c2"] = "dirt-left-crack-2",
	["1111-01-c2"] = "dirt-crack-2",
	["1011-01-c2"] = "dirt-right-crack-2",
	["1110-01-c3"] = "dirt-left-crack-3",
	["1111-01-c3"] = "dirt-crack-3",
	["1011-01-c3"] = "dirt-right-crack-3",
	["~1110-01"] = "dirt-left-grass",
	["~1111-01"] = "dirt-grass",
	["~1011-01"] = "dirt-right-grass",
	["~1110-01-c1"] = "dirt-left-crack-1-grass",
	["~1111-01-c1"] = "dirt-crack-1-grass",
	["~1011-01-c1"] = "dirt-right-crack-1-grass",
	["~1110-01-c2"] = "dirt-left-crack-2-grass",
	["~1111-01-c2"] = "dirt-crack-2-grass",
	["~1011-01-c2"] = "dirt-right-crack-2-grass",
	["~1110-01-c3"] = "dirt-left-crack-3-grass",
	["~1111-01-c3"] = "dirt-crack-3-grass",
	["~1011-01-c3"] = "dirt-right-crack-3-grass",
	["1100-01"] = "dirt-left-bottom",
	["1101-01"] = "dirt-bottom",
	["1001-01"] = "dirt-right-bottom",
	["1100-01-c1"] = "dirt-left-bottom-crack-1",
	["1101-01-c1"] = "dirt-bottom-crack-1",
	["1001-01-c1"] = "dirt-right-bottom-crack-1",
	["1100-01-c2"] = "dirt-left-bottom-crack-2",
	["1101-01-c2"] = "dirt-bottom-crack-2",
	["1001-01-c2"] = "dirt-right-bottom-crack-2",
	["1100-01-c3"] = "dirt-left-bottom-crack-3",
	["1101-01-c3"] = "dirt-bottom-crack-3",
	["1001-01-c3"] = "dirt-right-bottom-crack-3",
	["~1100-01"] = "dirt-left-bottom-grass",
	["~1101-01"] = "dirt-bottom-grass",
	["~1001-01"] = "dirt-right-bottom-grass",
	["~1100-01-c1"] = "dirt-left-bottom-crack-1-grass",
	["~1101-01-c1"] = "dirt-bottom-crack-1-grass",
	["~1001-01-c1"] = "dirt-right-bottom-crack-1-grass",
	["~1100-01-c2"] = "dirt-left-bottom-crack-2-grass",
	["~1101-01-c2"] = "dirt-bottom-crack-2-grass",
	["~1001-01-c2"] = "dirt-right-bottom-crack-2-grass",
	["~1100-01-c3"] = "dirt-left-bottom-crack-3-grass",
	["~1101-01-c3"] = "dirt-bottom-crack-3-grass",
	["~1001-01-c3"] = "dirt-right-bottom-crack-3-grass",
	["0010-01"] = "dirt-top-right-left",
	["0010-01-c1"] = "dirt-top-right-left-crack-1",
	["0010-01-c2"] = "dirt-top-right-left-crack-2",
	["0010-01-c3"] = "dirt-top-right-left-crack-3",
	["0000-02"] = "iron-ore-all",
	["~0000-02"] = "iron-ore-all-grass",
	["~0000-02-c1"] = "iron-ore-all-crack-1-grass",
	["~0000-02-c2"] = "iron-ore-all-crack-2-grass",
	["~0000-02-c3"] = "iron-ore-all-crack-3-grass",
	["1000-02"] = "iron-ore-right-bottom-left",
	["1000-02-c1"] = "iron-ore-right-bottom-left-crack-1",
	["1000-02-c2"] = "iron-ore-right-bottom-left-crack-2",
	["1000-02-c3"] = "iron-ore-right-bottom-left-crack-3",
	["~1000-02"] = "iron-ore-all-grass",
	["~1000-02-c1"] = "iron-ore-all-crack-1-grass",
	["~1000-02-c2"] = "iron-ore-all-crack-2-grass",
	["~1000-02-c3"] = "iron-ore-all-crack-3-grass",
	["1010-02"] = "iron-ore-right-left",
	["1010-02-c1"] = "iron-ore-right-left-crack-1",
	["1010-02-c2"] = "iron-ore-right-left-crack-2",
	["1010-02-c3"] = "iron-ore-right-left-crack-3",
	["~1010-02"] = "iron-ore-right-left-grass",
	["~1010-02-c1"] = "iron-ore-right-left-crack-1-grass",
	["~1010-02-c2"] = "iron-ore-right-left-crack-2-grass",
	["~1010-02-c3"] = "iron-ore-right-left-crack-3-grass",
	["0100-02"] = "iron-ore-top-bottom-left",
	["0100-02-c1"] = "iron-ore-top-bottom-left-crack-1",
	["0100-02-c2"] = "iron-ore-top-bottom-left-crack-2",
	["0100-02-c3"] = "iron-ore-top-bottom-left-crack-3",
	["0101-02"] = "iron-ore-top-bottom",
	["0101-02-c1"] = "iron-ore-top-bottom-crack-1",
	["0101-02-c2"] = "iron-ore-top-bottom-crack-2",
	["0101-02-c3"] = "iron-ore-top-bottom-crack-3",
	["0001-02"] = "iron-ore-top-right-bottom",
	["0001-02-c1"] = "iron-ore-top-right-bottom-crack-1",
	["0001-02-c2"] = "iron-ore-top-right-bottom-crack-2",
	["0001-02-c3"] = "iron-ore-top-right-bottom-crack-3",
	["0000-02-c1"] = "iron-ore-all-crack-1",
	["0000-02-c2"] = "iron-ore-all-crack-2",
	["0000-02-c3"] = "iron-ore-all-crack-3",
	["0110-02"] = "iron-ore-top-left",
	["0111-02"] = "iron-ore-top",
	["0011-02"] = "iron-ore-top-right",
	["0110-02-c1"] = "iron-ore-top-left-crack-1",
	["0111-02-c1"] = "iron-ore-top-crack-1",
	["0011-02-c1"] = "iron-ore-top-right-crack-1",
	["0110-02-c2"] = "iron-ore-top-left-crack-2",
	["0111-02-c2"] = "iron-ore-top-crack-2",
	["0110-02-c3"] = "iron-ore-top-left-crack-3",
	["0011-02-c2"] = "iron-ore-top-right-crack-2",
	["0111-02-c3"] = "iron-ore-top-crack-3",
	["0011-02-c3"] = "iron-ore-top-right-crack-3",
	["~0110-02"] = "iron-ore-top-left-grass",
	["~0111-02"] = "iron-ore-top-grass",
	["~0011-02"] = "iron-ore-top-right-grass",
	["~0110-02-c1"] = "iron-ore-top-left-crack-1-grass",
	["~0111-02-c1"] = "iron-ore-top-crack-1-grass",
	["~0011-02-c1"] = "iron-ore-top-right-crack-1-grass",
	["~0110-02-c2"] = "iron-ore-top-left-crack-2-grass",
	["~0111-02-c2"] = "iron-ore-top-crack-2-grass",
	["~0011-02-c2"] = "iron-ore-top-right-crack-2-grass",
	["~0110-02-c3"] = "iron-ore-top-left-crack-3-grass",
	["~0111-02-c3"] = "iron-ore-top-crack-3-grass",
	["~0011-02-c3"] = "iron-ore-top-right-crack-3-grass",
	["1110-02"] = "iron-ore-left",
	["1111-02"] = "iron-ore",
	["1011-02"] = "iron-ore-right",
	["1110-02-c1"] = "iron-ore-left-crack-1",
	["1111-02-c1"] = "iron-ore-crack-1",
	["1011-02-c1"] = "iron-ore-right-crack-1",
	["1110-02-c2"] = "iron-ore-left-crack-2",
	["1111-02-c2"] = "iron-ore-crack-2",
	["1011-02-c2"] = "iron-ore-right-crack-2",
	["1110-02-c3"] = "iron-ore-left-crack-3",
	["1111-02-c3"] = "iron-ore-crack-3",
	["1011-02-c3"] = "iron-ore-right-crack-3",
	["~1110-02"] = "iron-ore-left-grass",
	["~1111-02"] = "iron-ore-grass",
	["~1011-02"] = "iron-ore-right-grass",
	["~1110-02-c1"] = "iron-ore-left-crack-1-grass",
	["~1111-02-c1"] = "iron-ore-crack-1-grass",
	["~1011-02-c1"] = "iron-ore-right-crack-1-grass",
	["~1110-02-c2"] = "iron-ore-left-crack-2-grass",
	["~1111-02-c2"] = "iron-ore-crack-2-grass",
	["~1011-02-c2"] = "iron-ore-right-crack-2-grass",
	["~1110-02-c3"] = "iron-ore-left-crack-3-grass",
	["~1111-02-c3"] = "iron-ore-crack-3-grass",
	["~1011-02-c3"] = "iron-ore-right-crack-3-grass",
	["1100-02"] = "iron-ore-left-bottom",
	["1101-02"] = "iron-ore-bottom",
	["1001-02"] = "iron-ore-right-bottom",
	["1100-02-c1"] = "iron-ore-left-bottom-crack-1",
	["1101-02-c1"] = "iron-ore-bottom-crack-1",
	["1001-02-c1"] = "iron-ore-right-bottom-crack-1",
	["1100-02-c2"] = "iron-ore-left-bottom-crack-2",
	["1101-02-c2"] = "iron-ore-bottom-crack-2",
	["1001-02-c2"] = "iron-ore-right-bottom-crack-2",
	["1100-02-c3"] = "iron-ore-left-bottom-crack-3",
	["1101-02-c3"] = "iron-ore-bottom-crack-3",
	["1001-02-c3"] = "iron-ore-right-bottom-crack-3",
	["~1100-02"] = "iron-ore-left-bottom-grass",
	["~1101-02"] = "iron-ore-bottom-grass",
	["~1001-02"] = "iron-ore-right-bottom-grass",
	["~1100-02-c1"] = "iron-ore-left-bottom-crack-1-grass",
	["~1101-02-c1"] = "iron-ore-bottom-crack-1-grass",
	["~1001-02-c1"] = "iron-ore-right-bottom-crack-1-grass",
	["~1100-02-c2"] = "iron-ore-left-bottom-crack-2-grass",
	["~1101-02-c2"] = "iron-ore-bottom-crack-2-grass",
	["~1001-02-c2"] = "iron-ore-right-bottom-crack-2-grass",
	["~1100-02-c3"] = "iron-ore-left-bottom-crack-3-grass",
	["~1101-02-c3"] = "iron-ore-bottom-crack-3-grass",
	["~1001-02-c3"] = "iron-ore-right-bottom-crack-3-grass",
	["0010-02"] = "iron-ore-top-right-left",
	["0010-02-c1"] = "iron-ore-top-right-left-crack-1",
	["0010-02-c2"] = "iron-ore-top-right-left-crack-2",
	["0010-02-c3"] = "iron-ore-top-right-left-crack-3",
	["0000-03"] = "gold-ore-all",
	["~0000-03"] = "gold-ore-all-grass",
	["~0000-03-c1"] = "gold-ore-all-crack-1-grass",
	["~0000-03-c2"] = "gold-ore-all-crack-2-grass",
	["~0000-03-c3"] = "gold-ore-all-crack-3-grass",
	["1000-03"] = "gold-ore-right-bottom-left",
	["1000-03-c1"] = "gold-ore-right-bottom-left-crack-1",
	["1000-03-c2"] = "gold-ore-right-bottom-left-crack-2",
	["1000-03-c3"] = "gold-ore-right-bottom-left-crack-3",
	["~1000-03"] = "gold-ore-all-grass",
	["~1000-03-c1"] = "gold-ore-all-crack-1-grass",
	["~1000-03-c2"] = "gold-ore-all-crack-2-grass",
	["~1000-03-c3"] = "gold-ore-all-crack-3-grass",
	["1010-03"] = "gold-ore-right-left",
	["1010-03-c1"] = "gold-ore-right-left-crack-1",
	["1010-03-c2"] = "gold-ore-right-left-crack-2",
	["1010-03-c3"] = "gold-ore-right-left-crack-3",
	["~1010-03"] = "gold-ore-right-left-grass",
	["~1010-03-c1"] = "gold-ore-right-left-crack-1-grass",
	["~1010-03-c2"] = "gold-ore-right-left-crack-2-grass",
	["~1010-03-c3"] = "gold-ore-right-left-crack-3-grass",
	["0100-03"] = "gold-ore-top-bottom-left",
	["0100-03-c1"] = "gold-ore-top-bottom-left-crack-1",
	["0100-03-c2"] = "gold-ore-top-bottom-left-crack-2",
	["0100-03-c3"] = "gold-ore-top-bottom-left-crack-3",
	["0101-03"] = "gold-ore-top-bottom",
	["0101-03-c1"] = "gold-ore-top-bottom-crack-1",
	["0101-03-c2"] = "gold-ore-top-bottom-crack-2",
	["0101-03-c3"] = "gold-ore-top-bottom-crack-3",
	["0001-03"] = "gold-ore-top-right-bottom",
	["0001-03-c1"] = "gold-ore-top-right-bottom-crack-1",
	["0001-03-c2"] = "gold-ore-top-right-bottom-crack-2",
	["0001-03-c3"] = "gold-ore-top-right-bottom-crack-3",
	["0000-03-c1"] = "gold-ore-all-crack-1",
	["0000-03-c2"] = "gold-ore-all-crack-2",
	["0000-03-c3"] = "gold-ore-all-crack-3",
	["0110-03"] = "gold-ore-top-left",
	["0111-03"] = "gold-ore-top",
	["0011-03"] = "gold-ore-top-right",
	["0110-03-c1"] = "gold-ore-top-left-crack-1",
	["0111-03-c1"] = "gold-ore-top-crack-1",
	["0011-03-c1"] = "gold-ore-top-right-crack-1",
	["0110-03-c2"] = "gold-ore-top-left-crack-2",
	["0111-03-c2"] = "gold-ore-top-crack-2",
	["0110-03-c3"] = "gold-ore-top-left-crack-3",
	["0011-03-c2"] = "gold-ore-top-right-crack-2",
	["0111-03-c3"] = "gold-ore-top-crack-3",
	["0011-03-c3"] = "gold-ore-top-right-crack-3",
	["~0110-03"] = "gold-ore-top-left-grass",
	["~0111-03"] = "gold-ore-top-grass",
	["~0011-03"] = "gold-ore-top-right-grass",
	["~0110-03-c1"] = "gold-ore-top-left-crack-1-grass",
	["~0111-03-c1"] = "gold-ore-top-crack-1-grass",
	["~0011-03-c1"] = "gold-ore-top-right-crack-1-grass",
	["~0110-03-c2"] = "gold-ore-top-left-crack-2-grass",
	["~0111-03-c2"] = "gold-ore-top-crack-2-grass",
	["~0011-03-c2"] = "gold-ore-top-right-crack-2-grass",
	["~0110-03-c3"] = "gold-ore-top-left-crack-3-grass",
	["~0111-03-c3"] = "gold-ore-top-crack-3-grass",
	["~0011-03-c3"] = "gold-ore-top-right-crack-3-grass",
	["1110-03"] = "gold-ore-left",
	["1111-03"] = "gold-ore",
	["1011-03"] = "gold-ore-right",
	["1110-03-c1"] = "gold-ore-left-crack-1",
	["1111-03-c1"] = "gold-ore-crack-1",
	["1011-03-c1"] = "gold-ore-right-crack-1",
	["1110-03-c2"] = "gold-ore-left-crack-2",
	["1111-03-c2"] = "gold-ore-crack-2",
	["1011-03-c2"] = "gold-ore-right-crack-2",
	["1110-03-c3"] = "gold-ore-left-crack-3",
	["1111-03-c3"] = "gold-ore-crack-3",
	["1011-03-c3"] = "gold-ore-right-crack-3",
	["~1110-03"] = "gold-ore-left-grass",
	["~1111-03"] = "gold-ore-grass",
	["~1011-03"] = "gold-ore-right-grass",
	["~1110-03-c1"] = "gold-ore-left-crack-1-grass",
	["~1111-03-c1"] = "gold-ore-crack-1-grass",
	["~1011-03-c1"] = "gold-ore-right-crack-1-grass",
	["~1110-03-c2"] = "gold-ore-left-crack-2-grass",
	["~1111-03-c2"] = "gold-ore-crack-2-grass",
	["~1011-03-c2"] = "gold-ore-right-crack-2-grass",
	["~1110-03-c3"] = "gold-ore-left-crack-3-grass",
	["~1111-03-c3"] = "gold-ore-crack-3-grass",
	["~1011-03-c3"] = "gold-ore-right-crack-3-grass",
	["1100-03"] = "gold-ore-left-bottom",
	["1101-03"] = "gold-ore-bottom",
	["1001-03"] = "gold-ore-right-bottom",
	["1100-03-c1"] = "gold-ore-left-bottom-crack-1",
	["1101-03-c1"] = "gold-ore-bottom-crack-1",
	["1001-03-c1"] = "gold-ore-right-bottom-crack-1",
	["1100-03-c2"] = "gold-ore-left-bottom-crack-2",
	["1101-03-c2"] = "gold-ore-bottom-crack-2",
	["1001-03-c2"] = "gold-ore-right-bottom-crack-2",
	["1100-03-c3"] = "gold-ore-left-bottom-crack-3",
	["1101-03-c3"] = "gold-ore-bottom-crack-3",
	["1001-03-c3"] = "gold-ore-right-bottom-crack-3",
	["~1100-03"] = "gold-ore-left-bottom-grass",
	["~1101-03"] = "gold-ore-bottom-grass",
	["~1001-03"] = "gold-ore-right-bottom-grass",
	["~1100-03-c1"] = "gold-ore-left-bottom-crack-1-grass",
	["~1101-03-c1"] = "gold-ore-bottom-crack-1-grass",
	["~1001-03-c1"] = "gold-ore-right-bottom-crack-1-grass",
	["~1100-03-c2"] = "gold-ore-left-bottom-crack-2-grass",
	["~1101-03-c2"] = "gold-ore-bottom-crack-2-grass",
	["~1001-03-c2"] = "gold-ore-right-bottom-crack-2-grass",
	["~1100-03-c3"] = "gold-ore-left-bottom-crack-3-grass",
	["~1101-03-c3"] = "gold-ore-bottom-crack-3-grass",
	["~1001-03-c3"] = "gold-ore-right-bottom-crack-3-grass",
	["0010-03"] = "gold-ore-top-right-left",
	["0010-03-c1"] = "gold-ore-top-right-left-crack-1",
	["0010-03-c2"] = "gold-ore-top-right-left-crack-2",
	["0010-03-c3"] = "gold-ore-top-right-left-crack-3",
}

STATE.ResourceWeightMap = {
	[STATE.ReverseTileTypeEnum[STATE.TileTypeEnum.IRON_ORE]] = 5,
	[STATE.ReverseTileTypeEnum[STATE.TileTypeEnum.GOLD_ORE]] = 10
}

STATE.game_state = {
	[STATE.StateEnum.Physics.Gravity] = -1900,
	[STATE.StateEnum.Player.MaxEnergy] = 50,
	[STATE.StateEnum.Player.CurrentEnergy] = 50,
	[STATE.StateEnum.Player.MaxSpeed] = 150,
	[STATE.StateEnum.Player.MaxHealth] = 100,
	[STATE.StateEnum.Player.CurrentHealth] = 100,
	[STATE.StateEnum.Player.Coins] = 8132714,
	[STATE.StateEnum.Player.MiningDamage] = 50,
	[STATE.StateEnum.Player.BeltItems] = {"rusty_pickaxe"},
	[STATE.StateEnum.Player.SelectedTool] = nil,
	[STATE.StateEnum.Inventory.Row] = 2,
	[STATE.StateEnum.Inventory.Col] = 4,
	[STATE.StateEnum.Inventory.Items.Resources] = {},
	[STATE.StateEnum.Inventory.Weight] = 0,
	[STATE.StateEnum.Inventory.MaxWeight] = 50,
	[STATE.StateEnum.Inventory.MaxItems] = 2,
	[STATE.StateEnum.Inventory.Type] = STATE.InventoryTypeEnum.POUCH,
	[STATE.StateEnum.Level.TileSize] = 64,
	[STATE.StateEnum.Level.MaxRoundTimeSeconds] = 180,
	[STATE.StateEnum.Level.MouseOverTileHash] = nil,
	[STATE.StateEnum.Level.Tiles] = {},
	[STATE.StateEnum.Settings.FullScreen] = false
}


local function get_key(x, y)
	return ("%d-%d"):format(x, y)
end

function STATE.get_sprite(x, y)
	local map = STATE.game_state[STATE.StateEnum.Level.Tiles]
	
	local current_tile = map[get_key(x, y)]
	
	local top_tile = map[get_key(x, y + 1)]
	local left_tile = map[get_key(x - 1, y)]
	local right_tile = map[get_key(x + 1, y)]
	local bottom_tile = map[get_key(x, y - 1)]

	local grass = y == 0 and "~" or ""
	local top = (top_tile ~= nil and top_tile.tile_type == STATE.TileTypeEnum.EMPTY) and "0" or "1"
	local right = (right_tile ~= nil and right_tile.tile_type == STATE.TileTypeEnum.EMPTY) and "0" or "1"
	local bottom = (bottom_tile ~= nil and bottom_tile.tile_type == STATE.TileTypeEnum.EMPTY) and "0" or "1"
	local left = (left_tile ~= nil and left_tile.tile_type == STATE.TileTypeEnum.EMPTY) and "0" or "1"

	local tile_type = "-0" .. current_tile.tile_type
	
	local crack_level = ""

	if current_tile.hitpoints ~= nil and current_tile.hitpoints ~= STATE.TileTypeToHitpoints[current_tile.tile_type] then

		local initial_hitpoints = STATE.TileTypeToHitpoints[current_tile.tile_type]

		if current_tile.hitpoints >= initial_hitpoints * 0.66 then
			crack_level = "-c1"
		elseif current_tile.hitpoints < initial_hitpoints * 0.66 and current_tile.hitpoints > current_tile.hitpoints * 0.33 then
			crack_level = "-c2"
		elseif current_tile.hitpoints <= initial_hitpoints * 0.33 then
			crack_level = "-c3"
		end
	end

	local new_sprite_code = grass .. top .. right .. bottom .. left .. tile_type .. crack_level
    return STATE.TileSpriteAnimations[new_sprite_code]
end

-- resets player stats for each round
function STATE.reset_player_stats()
	STATE.game_state[STATE.StateEnum.Player.CurrentEnergy] = STATE.game_state[STATE.StateEnum.Player.MaxEnergy]
	STATE.game_state[STATE.StateEnum.Player.CurrentHealth] = STATE.game_state[STATE.StateEnum.Player.MaxHealth]
	STATE.game_state[STATE.StateEnum.Inventory.Items.Resources] = {}
end

function STATE.game_state.get_state_property(property)
	return STATE.game_state[property]
end

function STATE.game_state.set_state_property(property, newValue)
	STATE.game_state[property] = newValue
	return newValue
end

return STATE



