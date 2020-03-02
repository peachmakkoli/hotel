require 'date'

module Hotel
	class Reservation
		attr_reader :id, :room
		attr_accessor :start_date, :end_date

		def initialize(id:, room:, start_date:, end_date:)
			@id = id
			@start_date = Date.parse(start_date)
			@end_date = Date.parse(end_date)
		end		
	
		# define a method that calculates the number of nights for each stay, depending on the date range
	end
end