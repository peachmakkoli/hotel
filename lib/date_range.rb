module Hotel
	class DateRange
		attr_accessor :start_date, :end_date

		def initialize(start_date:, end_date:)
			@start_date = start_date
			@end_date = end_date
			
			raise ArgumentError.new("Invalid date range!") if @start_date > @end_date
		end	
	end
end