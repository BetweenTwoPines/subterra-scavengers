local STATE = {}

STATE.StateEnum = {
	Player = {
		MaxEnergy = "player_max_energy",
		CurrentEnergy = "player_current_energy",
		MaxSpeed = "player_max_speed",
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
		Weight = "inventory_weight",
		Items = {
			Resources = "inventory_items_resources"
			-- TODO Items
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

STATE.TileSpriteAnimations = {
	DIRT = "dirt-1",
	DIRT_BROKEN_2 = "dirt-2",
	DIRT_BROKEN_3 = "dirt-3",
	DIRT_BROKEN_4 = "dirt-4",
	IRON_ORE = "iron-ore-1",
	IRON_ORE_BROKEN_2 = "iron-ore-2",
	IRON_ORE_BROKEN_3 = "iron-ore-3",
	IRON_ORE_BROKEN_4 = "iron-ore-4",
	GOLD_ORE = "gold-ore-1",
	GOLD_ORE_BROKEN_2 = "gold-ore-2",
	GOLD_ORE_BROKEN_3 = "gold-ore-3",
	GOLD_ORE_BROKEN_4 = "gold-ore-4",
}

STATE.ResourceWeightMap = {
	[STATE.TileTypeEnum.IRON_ORE] = 5,
	[STATE.TileTypeEnum.GOLD_ORE] = 10
}

STATE.game_state = {
	[STATE.StateEnum.Physics.Gravity] = -1900,
	[STATE.StateEnum.Player.MaxEnergy] = 50,
	[STATE.StateEnum.Player.CurrentEnergy] = 50,
	[STATE.StateEnum.Player.MaxSpeed] = 150,
	[STATE.StateEnum.Player.MaxHealth] = 100,
	[STATE.StateEnum.Player.CurrentHealth] = 100,
	[STATE.StateEnum.Player.Coins] = 50,
	[STATE.StateEnum.Player.BeltItems] = {"rusty_pickaxe"},
	[STATE.StateEnum.Player.SelectedTool] = nil,
	[STATE.StateEnum.Inventory.Row] = 2,
	[STATE.StateEnum.Inventory.Col] = 4,
	[STATE.StateEnum.Inventory.Items.Resources] = {},
	[STATE.StateEnum.Inventory.Weight] = 0,
	[STATE.StateEnum.Inventory.MaxWeight] = 50,
	[STATE.StateEnum.Inventory.Type] = STATE.InventoryTypeEnum.POUCH,
	[STATE.StateEnum.Level.TileSize] = 64,
	[STATE.StateEnum.Level.MaxRoundTimeSeconds] = 180,
	[STATE.StateEnum.Level.MouseOverTileHash] = nil,
	[STATE.StateEnum.Level.Tiles] = {}
}

-- resets player stats for each round
function STATE.reset_player_stats()
	STATE.game_state[STATE.StateEnum.Player.CurrentEnergy] = STATE.game_state[STATE.StateEnum.Player.MaxEnergy]
	STATE.game_state[STATE.StateEnum.Player.CurrentHealth] = STATE.game_state[STATE.StateEnum.Player.MaxHealth]
end

function STATE.game_state.get_state_property(property)
	return STATE.game_state[property]
end

function STATE.game_state.set_state_property(property, newValue)
	STATE.game_state[property] = newValue
	return newValue
end

return STATE


