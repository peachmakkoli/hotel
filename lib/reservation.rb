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
	
		# define a method that calculates the number of nights for each stay, depending on the date range

		# I can get the total cost for a given reservation
	end
end