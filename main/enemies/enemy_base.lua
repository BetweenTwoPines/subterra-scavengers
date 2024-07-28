local state = require "main.state.game"
local function create_enemy()
	local M = {}

	function M.init(self)
		-- Default enemy properties
		self.base_health = 100
		self.base_speed = 50
		self.base_damage = 10
		
		-- Animation properties
		self.anim_idle = nil
		self.anim_move_left = nil
		self.anim_move_right = nil
		self.anim_attack_left = nil
		self.anim_attack_right = nil
		self.current_animation = nil -- the currently playing animation

		-- Movement specific properties
		self.start_pos = go.get_position()
		self.direction = 1 -- 1 for right, -1 for left
		self.move_distance = 100 -- Total distance to move left and right in a single spot
		self.moved_distance = 0 -- Distance moved from the start position
		self.moving = false -- determines if enemy is moving
		self.debounce_time = 0 -- keep track of how much time has passed since enemy stopped before starting to move again
		self.base_max_movement_delay = 1 -- Max delay before enemy starts moving again

		-- Attack properties
		self.attacking = false
		self.base_attack_range = 20 -- min distance to when enemy should start attacking

		-- Player detection properties
		self.player = "/player/player"
		self.detection_range = 200 -- min distance within which the enemy will start moving towards the player
	end

	local function get_distance_to_player(self)
		local pos = go.get_position()
		local player_pos = go.get_position(self.player)
		return vmath.length(player_pos - pos)
	end

	local function handle_attack(self)
		local distance_to_player = get_distance_to_player(self)
		
		if distance_to_player < self.attack_range then
			local newHealth = state.game_state[state.StateEnum.Player.CurrentHealth] - self.damage
			if newHealth <= 0 then
				-- take plater back to menu once they are dead
				msg.post("proxy:/controller#controller", "load_menu")
			else
				-- udpdate health after enemy attacks player
				state.game_state[state.StateEnum.Player.CurrentHealth] = newHealth
				msg.post("/gui#ui", "update_heatlh")
			end
		end
	end

	
	local function anim_done(self, message_id, message, sender)
		if message_id == hash("animation_done") then
			if message.id == self.anim_attack_right or message.id == self.anim_attack_left then
				self.attacking = false;
				handle_attack(self)
			end
		end
	end

	--[[
	anim - id of animation to play
	ignore_save - prevent storing previously playing animation (for example when attack needs to be playing again)
	]]

	local function play_animation(self, anim, ignore_save)
		-- only play animations which are not already playing
		if self.current_animation ~= anim then
			-- tell the sprite to play the animation
			sprite.play_flipbook("#sprite", anim, anim_done)
			-- remember which animation is playing
			if ignore_save then
				self.current_animation = nil
				return
			else
				self.current_animation = anim
			end
		end
	end

	local function update_animation(self)
		if self.attacking == true then
			local anim_attack = (self.direction == 1) and self.anim_attack_right or self.anim_attack_left
			play_animation(self, anim_attack, true)
		elseif self.moving == false then
			play_animation(self, self.anim_idle)
		elseif self.moving and self.direction == 1 then
			play_animation(self, self.anim_move_right)
		elseif self.moving and self.direction == -1 then
			play_animation(self, self.anim_move_left)
		end
	end

	function M.update(self, dt)
		if self.attacking then
			-- When attacking let enemy finish attack animation before starting to move again
			return
		end
		if self.debounce_time > 0 then
			-- Puase enemy movement for base_max_movement_delay
			self.debounce_time = self.debounce_time - dt
			return
		end

		local pos = go.get_position()
		local player_pos = go.get_position(self.player)
		local distance_to_player = vmath.length(player_pos - pos)

		if distance_to_player < self.attack_range then
			self.attacking = true
		elseif distance_to_player < self.detection_range then
			-- Move towards the player
			self.moving = true
			local direction_to_player = vmath.normalize(player_pos - pos)
			local normalized_direction = (player_pos.x > pos.x) and 1 or -1
			pos = pos + direction_to_player * self.base_speed * dt
			self.direction = normalized_direction
		else
			-- handle randomized movement
			self.moving = true
			local move_step = self.base_speed * dt * self.direction
			pos.x = pos.x + move_step
			self.moved_distance = self.moved_distance + math.abs(move_step)

			-- Do we need to change direction
			if self.moved_distance >= self.move_distance then
				self.moving = false
				self.direction = self.direction * -1
				self.moved_distance = 0
				self.debounce_time = self.base_max_movement_delay -- Start debounce timer
			end
		end

		go.set_position(pos)
		update_animation(self)
	end

	return M
end

return create_enemy
