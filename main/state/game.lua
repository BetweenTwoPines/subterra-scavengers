local StateEnum = {
	Player = {
		MaxEnergy = "player_max_energy",
		CurrentEnergy = "player_current_energy",
		MaxSpeed = "player_max_speed",
		MaxHealth = "player_max_health",
		Coins = "player_coins"
	},
	Inventory = {
		Row = "inventory_size_row",
		Col = "inventory_size_col"
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

local game_state = {
	[StateEnum.Physics.Gravity] = -1900,
	[StateEnum.Player.MaxEnergy] = 50,
	[StateEnum.Player.CurrentEnergy] = 5,
	[StateEnum.Player.MaxSpeed] = 150,
	[StateEnum.Player.MaxHealth] = 100,
	[StateEnum.Player.Coins] = 50,
	[StateEnum.Inventory.Row] = 2,
	[StateEnum.Inventory.Col] = 4,
	[StateEnum.Level.TileSize] = 64,
	[StateEnum.Level.MaxRoundTimeSeconds] = 180,
	[StateEnum.Level.MouseOverTileHash] = nil,
	[StateEnum.Level.TileType] = {
		EMPTY = "empty",
		DIRT = "dirt",
		ORE = "ore"
	},
	[StateEnum.Level.Tiles] = {}
}

function game_state.get_state_property(property)
	return game_state[property]
end

function game_state.set_state_property(property, newValue)
	game_state[property] = newValue
	return newValue
end

return { StateEnum = StateEnum, game_state = game_state }