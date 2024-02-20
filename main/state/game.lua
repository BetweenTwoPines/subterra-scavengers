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
	Settings = {
		TileSize = "settings_tile_size",
		MaxRoundTimeSeconds = "settings_max_round_time_seconds"
	},
	Physics = {
		Gravity = "physics_gravity"
	}
}

local game_state = {
	[StateEnum.Player.MaxEnergy] = 5,
	[StateEnum.Player.CurrentEnergy] = 5,
	[StateEnum.Player.MaxSpeed] = 150,
	[StateEnum.Player.MaxHealth] = 100,
	[StateEnum.Player.Coins] = 50,
	[StateEnum.Inventory.Row] = 2,
	[StateEnum.Inventory.Col] = 4,
	[StateEnum.Settings.TileSize] = 64,
	[StateEnum.Physics.Gravity] = -1900,
	[StateEnum.Settings.MaxRoundTimeSeconds] = 99999
}

function game_state.get_state_property(property)
	return game_state[property]
end

function game_state.set_state_property(property, newValue)
	game_state[property] = newValue
	return newValue
end

return { StateEnum = StateEnum, game_state = game_state }