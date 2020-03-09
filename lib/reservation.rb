require_relative 'date_range'

module Hotel
	class Reservation
		attr_reader :id, :room, :block, :rate, :date_range

		def initialize(id:, room:, block: false, rate: 200.0, start_date:, end_date:)
			@id = id
			@room = room
			@block = block
			@rate = rate
			@date_range = Hotel::DateRange.new(
				start_date: start_date, 
				end_date: end_date
			)
		end	

		def total_cost
			return @date_range.nights * @rate 
		end
	end
end