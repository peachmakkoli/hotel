require 'date'

module Hotel
	class Block
		attr_reader :id, :rooms, :rate, :date_range

		def initialize(id:, rooms:, rate:, start_date:, end_date:)
			@id = id
			@rooms = rooms
			@rate = rate
			@date_range = Hotel::DateRange.new(
				start_date: start_date, 
				end_date: end_date
			)
			
			raise ArgumentError.new("Block must contain between 2 and 5 rooms!") if @rooms.length < 2 || @rooms.length > 5
		end

		# I can check whether a given block has any rooms available

		# I can reserve a specific room from a hotel block
		# I can only reserve that room from a hotel block for the full duration of the block
	end
end