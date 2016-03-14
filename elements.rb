require_relative "default"

class Element
	
	def initialize(elements_manager)
		@elements_manager = elements_manager
	end

	def interact
	end
end

class Monster < Element

	def initialize
		@high_aggressivity =  Random.rand(99) < 50 
	end

	def interact

	end
end

class Dice

end

class ElementsManager

	def initialize(game_coordinator)
		@game_coordinator = game_coordinator
	end

	private

	def place_monsters

	end

	def place_coin

	end

	def place_element

	end

end


