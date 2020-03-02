module Hotel
	class Reservation
		attr_reader :id, :start_date, :end_date, :nights

		def initialize(id:, start_date:, end_date:, nights: nil)
			@id = id
			@start_date = Date.parse(start_date)
			@end_date = Date.parse(end_date)
			@nights = nights
		end		
	
		# define a method that calculates the number of nights for each stay, depending on the date range
	end
end