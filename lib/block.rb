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
	end
end