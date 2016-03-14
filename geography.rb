require_relative 'default'

class Place

	attr_accessor :label

	def initialize(game_coordinator)
		@coordinator = game_coordinator
	end

	def explore_place
		puts ENTERING_IN_NEW_ROOM % @label
		# TODO: Look for monsters
		# TODO: Look for coins
		# TODO: Print standard question
	end

	def ask_for_door
		puts CHOOSE_A_DOOR
		print INPUT
		door_integer = $stdin.gets.chomp.to_i
		check_door_number(door_integer)
		map_door_to_ordinal(door_integer)
	end

	private

	def check_door_number(door_number)
		if !(0 <= door_number) && !(door_number<= 3)
			puts DOOR_ERROR 
			print INPUT
			check_door_number( $stdin.gets.chomp)
		end
	end

	def map_door_to_ordinal(door_number)
		DIRECTION_MAP[ door_number ] 
	end

end

class Abyss < Place
	
	def explore_place
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
