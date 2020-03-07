require 'date'
require_relative 'date_range'

module Hotel
	class Reservation
		attr_reader :id, :room, :date_range

		def initialize(id:, room:, start_date:, end_date:)
			@id = id
			@room = room
			@date_range = Hotel::DateRange.new(
				start_date: start_date, 
				end_date: end_date
			)
		end	

		def total_cost
			return @date_range.nights * 200.0
		end
	end
end