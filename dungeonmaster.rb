=begin
	Player = Struct.new(:name, :location)
	Room = Struct.new(:reference, :name, :description, :connections)

	Structs can be used to store data. it is shorthand for all the 
	initalizing and variable placing that is noramlly done when
	classes are created.. but once classes are actually doing things
	other than storing data.. the normal class structure is required
end
=end


class Dungeon
	attr_accessor :player

	def initialize(player_name)
		@player = Player.new(player_name)
		@rooms = []
	end

	def add_room(reference, name, description, connections)
		@rooms << Room.new(reference, name, description, connections)
	end

	def start(location)
		@player.location = location
		show_current_description
	end

	def show_current_description #outsources the iteration and outsources the description
		puts find_room_in_dungeon(@player.location).full_description
	end
 
	def find_room_in_dungeon(reference)  #iterates through all of the rooms to find a match
		@rooms.detect { |room| room.reference == reference }
	end

	def find_room_in_direction(direction)  #finds the connection of two rooms
		find_room_in_dungeon(@player.location).connections[direction]
	end

	def go(direction)   #declares the movement, confirms the connection of the rooms, outsources the new location description
		puts "\n\nYou go " + direction.to_s
		@player.location = find_room_in_direction(direction)
		show_current_description
	end


	class Player #keeps track of players name and current location
		attr_accessor :name, :location

		def initialize(name)
			@name = name
		end
	end

	class Room # stores information about the rooms and movement
		attr_accessor :reference, :name, :description, :connections

		def initialize(reference, name, description, connections)
			@reference = reference
			@name = name
			@description = description
			@connections = connections
		end

		def full_description #declares the description
			@name + "\n\nYou are in " + @description
		end
	end


end
#creates main dungeon
my_dungeon = Dungeon.new("Quest")

#adding rooms
my_dungeon.add_room(:largecave, "\nLarge Cave", "a large cavernous cave, \nthere is only one exit to the west", {:west => :smallcave})
my_dungeon.add_room(:smallcave, "\nSmall Cave", "a small, claustraphobic cave, \n there is only one exit to the east", {:east => :largecave})



my_dungeon.start(:largecave)

puts "\n\ntype in the direction you want to go, \nor say 'location' for your current location \n\n"


while true
	input = gets.chomp.downcase
	if input == 'location'
		my_dungeon.show_current_description
	elsif my_dungeon.find_room_in_direction(input.to_sym) != nil
		my_dungeon.go(input.to_sym)
	else
		puts "\n\nYou scour the area but are unable to find what you are looking for, try your entry again"
	end

end






