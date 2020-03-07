require 'date'

module Hotel
	class Block
		attr_reader :rooms, :rate, :date_range

		def initialize(rooms:, rate:, start_date:, end_date:)
			@rooms = rooms
			@rate = rate
			@date_range = Hotel::DateRange.new(
				start_date: start_date, 
				end_date: end_date
			)

			# Wave 3: I want an exception raised if I try to create a Hotel Block and at least one of the rooms is unavailable for the given date range
			
			# Wave 3: A block can contain a maximum of 5 rooms

			# Wave 3: When a room is reserved from a block of rooms, the reservation dates will always match the date range of the block
		end

		# I can check whether a given block has any rooms available

		# I can reserve a specific room from a hotel block
		# I can only reserve that room from a hotel block for the full duration of the block
	end
end