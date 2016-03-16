require_relative 'default'

class Place

	attr_accessor :label

	def initialize(game_coordinator)
		@coordinator = game_coordinator
	end

	def explore_place
		# Exploring a place consist in checking whether 
		# a monster or a coin are in the room and interact with
		# them
		puts ENTERING_IN_NEW_ROOM % @label
		possible_monster = @coordinator.monster_ask(self)
		if !possible_monster.nil?
			possible_monster.interact
		end
		possible_coin = @coordinator.coin_ask(self)
		if !possible_coin.nil?	
			possible_coin.interact
		end

	end

	def ask_for_door
		# We ask for the door that has to be used
		puts CHOOSE_A_DOOR
		print INPUT
		door = $stdin.gets.chomp
		door_checked = check_change_door_number(door)
		map_door_to_direction(door_checked)
	end

	private

	def check_change_door_number(door_number)
		# A valid door is only one contained in the DIRECTION_MAP Hash
		# Otherwise ask for a new one
		
		if  !DIRECTION_MAP.key?(door_number)
			puts DOOR_ERROR 
			print INPUT
			door_new = check_change_door_number( $stdin.gets.chomp)
		else
			return door_number
		end
	end

	def map_door_to_direction(door_number)
		# The door are mapped with the direction used by the graph
		# and set in the default file
		DIRECTION_MAP[ door_number ] 
	end

end

class Abyss < Place
	
	def explore_place
		# The Abyss is a particular place where
		# it possible only to die (in an horrible way)
		puts ABYSS_DEATH
		exit(0)
		# TODO add reload option
	end
	
	def move_to_next
		# it should not be called
	end

	def check_door_number
		# it should not be called
	end
end

class FloorGeography

	def initialize(game_coordinator)
		@places = Hash.new
		build_places_map( game_coordinator )
	end

	def get_place(label)
		@places[label.to_sym]	
	end

	private

	def build_places_map(game_coordinator)
		# Create an map (hash) containing the Places instances (including the Abyss)
		
		ROOM_NAMES.each { |label| 
				place = Place.new(game_coordinator) 
				place.label=(label.to_sym)  
				@places[label.to_sym] =  place }
		abyss = Abyss.new(game_coordinator)
		@places[:Abyss] =  abyss
	end


end
