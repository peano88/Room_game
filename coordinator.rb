require_relative "schema"
require_relative "geography"
require_relative "default"
require_relative "elements"

class GameCoordinator

	def initialize
		# The coordinator containes all the component of the game
		# here initialized
		@map = PrimitiveGraph.new
		@geography = FloorGeography.new(self)
		@elements_manager = ElementsManager.new(self)
		Schema.setup_schema(@map)
		build_places_allocation
		@coins_collected = 0
	end

	def start_game
		# Pick randomically the first room and start the game.
		# The game goes on until death (monster or abyss) or 
		# all coins are collected
		place = @geography.get_place(ROOM_NAMES.at(Random.rand(6)))	

		while game_over? != true 
			place.explore_place
			direction = place.ask_for_door
			place = move_to_next_place(place, direction)
		end
		puts CONGRATS
	end
	
	def monster_ask(place)
		# get the Monster from the element manager (nil in case)
		@elements_manager.monster_get(place.label.to_s)
	end

	def coin_ask(place)
		# get the coin from the element manager (nil in case)
		@elements_manager.coin_get(place.label.to_s)
	end

	def coin_collected
		# when a new coin is collected we increase the counter and check if the game
		# is over
		@coins_collected += 1
		if game_over?
			puts CONGRATS
			exit(0)
		end
	end

	private

	def game_over?
		# Apart from death, the game is over when all coins
		# are collected
		@coins_collected == COINS_NUMBER
	end
	
	def move_to_next_place(current_place, door)
		# In order to retrieve the next place where to move, we have 
		# to use first, the allocation table for the correct place_id, then ask
		# the graph which is the next node-->place_id and ask the geography to
		# give us back the place instance, once the next label is found using again 
		# the allocation table
		current_place_id = @places_allocation.key(current_place.label.to_s)
		next_place_id = @map.get_linked_node(current_place_id.to_s, door)
		next_place_label = @places_allocation[next_place_id.to_sym ]
		next_place = @geography.get_place( next_place_label )
	end
	
	def build_places_allocation
		# The id, building the fixed map of the floor as in the Graph (see graph.rb file) are fixed.
		# To entertain a bit more the player, the disposition of the labels (i.e. the name assigned to
		# each room) is randomically set

		@places_allocation = Hash.new

		places_label_shuffled = ROOM_NAMES.shuffle

		if ROOM_IDS.size != places_label_shuffled.size
			puts ROOM_ID_LABEL_SIZE_ERROR
			exit(0)
		end
		
		(0..places_label_shuffled.size).each do 
			|i| @places_allocation[ROOM_IDS[i].to_s.to_sym] = places_label_shuffled[i] end
		
		# This is always the same, because makes no sense to randomize the Abyss
		@places_allocation[:y] = 'Abyss'
	end

end

 GameCoordinator.new.start_game
