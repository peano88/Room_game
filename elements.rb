require_relative "default"

class Element
	
	def initialize(elements_manager)
		# initialize the attributes
		@elements_manager = elements_manager
		@role_is_over = false
	end

	def interact
		# if an element has lost its role 
		# (defeated or collected) can't interact 
		# with the player anymore
		if !@role_is_over
			do_interact
		end	
	end

	def do_interact
		# The subclass will implement this
	end
end

class Monster < Element

	attr_writer :name

	def initialize(elements_manager)
		# Based on the coin flip (50 %) the aggressivity parameters are set
		super(elements_manager)

	       if Random.rand(99) < 50
	       		@state = BAD_STATE
			@change = DECREASE_CHANGE
			@threshold = BAD_THRESHOLD
 		else
			@state = GOOD_STATE
			@change = INCREASE_CHANGE
			@threshold = GOOD_THRESHOLD
		end		
	end

	def do_interact
		# The monster ask you to roll a dice, with threshold set as an attribute
		# if the value is less, the monster win, otherwise it is
		# defeated
		puts MONSTER_PRESENTATION % @name
		puts MONSTER_ENGAGE % [@state, @change]
		puts MONSTER_CHALLENGE % @threshold
		print INPUT
		$stdin.gets
		if @elements_manager.roll_a_dice <= @threshold
			puts FIGHT_DEATH
			exit(0)
		else
			puts FIGHT_LIVE
			@role_is_over = true
		end
		
	end
end

class Coin < Element

	def do_interact
		# interaction with a coin is only the
		# colection of it, notifying the element manager
		puts COIN_TAKEN
		@elements_manager.coin_taken
		@role_is_over = true
	end

end	

class Dice
		
	def roll
		# Simulate the Rolling of a Dice, avoiding the infamous 0.
		result = 0
		while result == 0
			result = Random.rand(6)
		end
		print result
		return result
	end
end

class ElementsManager

	def initialize(game_coordinator)
		# The element manager places the various elements in the
		# map, and creates a Dice
		@game_coordinator = game_coordinator
		place_monsters
		place_coins
		@dice = Dice.new
	end

	def monster_get (room_name)
		@monsters_placement[room_name.to_sym]
	end

	def coin_get(room_name)
		@coins_placement[room_name.to_sym]
	end

	def roll_a_dice
		@dice.roll	
	end

	def coin_taken
		@game_coordinator.coin_collected
	end

	private

	def place_monsters
		# the Placement is random, shuffling the array of 
		# room names and creating maximum a monster in a room
		rooms_shuffled = ROOM_NAMES.shuffle
		@monsters_placement = Hash.new
		MONSTERS.each { |mname| 
		       monster_element = Monster.new(self)
	       		monster_element.name=(mname.to_sym)
	 		place_element(rooms_shuffled, monster_element,@monsters_placement) }		
	end

	def place_coins
		# Similar to the monster placement
		rooms_shuffled = ROOM_NAMES.shuffle
		@coins_placement = Hash.new
		COINS_NUMBER.times  { 
		       coin_element = Coin.new(self)
	 		place_element(rooms_shuffled, coin_element,@coins_placement) }	
	end

	def place_element(rooms_array, element, placement_map)
		# Maximum one for each kind of element can be place
		# in a room
		placement_map[rooms_array.pop.to_sym] = element

	end

end


