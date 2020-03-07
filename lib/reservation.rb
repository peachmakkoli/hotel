require 'date'
require_relative 'date_range'

module Hotel
	class Reservation
		attr_reader :id, :room, :block, :date_range

		def initialize(id:, room:, block: false, start_date:, end_date:)
			@id = id
			@room = room
			@block = block
			@date_range = Hotel::DateRange.new(
				start_date: start_date, 
				end_date: end_date
			)
		end	

		def total_cost
			return @date_range.nights * 200.0 # this needs to be changed to account for the discounted rate in hotel blocks
		end
	end
end