require 'date'

module Hotel
	class Reservation
		attr_reader :id, :room
		attr_accessor :start_date, :end_date

		def initialize(id:, room:, start_date:, end_date:)
			@id = id
			@room = room
			@start_date = start_date
			@end_date = end_date
			
			raise ArgumentError.new("Invalid date range!") if @start_date > @end_date
		end	
	
		def nights
			return @end_date - @start_date
		end

		def total_cost
			return nights * 200.0
		end
	end
end