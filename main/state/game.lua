local StateEnum = {
	Player = {
		MaxEnergy = "player_max_energy",
		MaxSpeed = "player_max_speed",
		MaxHealth = "player_max_health",
		Coins = "player_coins"
	},
	Inventory = {
		Row = "inventory_size_row",
		Col = "inventory_size_col"
	}
}

local game_state = {
	[StateEnum.Player.MaxEnergy] = 5,
	[StateEnum.Player.MaxSpeed] = 150,
	[StateEnum.Player.MaxHealth] = 100,
	[StateEnum.Player.Coins] = 50,
	[StateEnum.Inventory.Row] = 2,
	[StateEnum.Inventory.Col] = 4
}

function game_state.get_state_property(property)
	return game_state[property]
end

return { StateEnum = StateEnum, game_state = game_state }