--[[
This base enemy class provides a generic implementation for enemy behavior, 
including movement, attack, and player detection. To use this base class, 
follow the steps below:

In the specific enemy module do following:

1. Require the base enemy module:
	local enemy_base = require "main.enemies.enemy_base"

2. Define enemy-specific properties using go.property:
	go.property('health', 150)
	go.property('speed', 50)
	go.property('damage', 10)
	etc

	these can be used to override the base_* properties of the base class ex: 
	self.base_health = self.health
	
3. Define enemy-specific animations and implement update_animation function:
	local anim_idle = hash("enemy_idle")
	local anim_move_left = hash("enemy_move_left")
	etc

	local function update_animation(self)
		if self.attacking then
			local anim_attack = (self.direction == 1) and anim_attack_right or anim_attack_left
			self.worm.play_animation(self, anim_attack)
		elseif self.moving == false then
			self.worm.play_animation(self, anim_idle)
		end
	end

4. Implement the attack callback function:
	local function attack(self)
		print("Attacking the player!")
	end

5. Initialize the enemy in the init() function this will create a singleton of this class
	function init(self)
		self.enemy = enemy_base()
		self.enemy.init(self)

		-- Override base values
		self.base_health = self.health
		self.base_attack_range = self.attack_range
		self.on_attack = function(self) attack(self) end
	end
]]--

local function create_enemy()
	local M = {}

	function M.init(self)
		-- Default enemy properties
		self.base_health = 100
		self.base_speed = 50
		self.base_damage = 10

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

		-- Callback for attack implemented by derrived class
		self.on_attack = nil
	end

	--[[
	anim - id of animation to play
	callback - function to run at the end of animation
	ignore_save - prevent storing previously playing animation (for example when attack needs to be playing again)
	]]
	
	function M.play_animation(self, anim, callback, ignore_save)
		-- only play animations which are not already playing
		if self.current_animation ~= anim then
			-- tell the sprite to play the animation
			sprite.play_flipbook("#sprite", anim, callback)
			-- remember which animation is playing
			if ignore_save then
				self.current_animation = nil
				return
			else
				self.current_animation = anim
			end
		end
	end

	function M.distance_to_player(self)
		local pos = go.get_position()
		local player_pos = go.get_position(self.player)
		return vmath.length(player_pos - pos)
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
			if self.on_attack then
				-- call attack function from derrived class
				self.on_attack(self)
			else
				print("WARNING: on_attack not implemented")
			end
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
	end

	return M
end

return create_enemy
