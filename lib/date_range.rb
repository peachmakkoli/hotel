module Hotel
	class DateRange < Range
		attr_reader :dates
		attr_accessor :start_date, :end_date

		def initialize(start_date:, end_date:)
			@start_date = start_date
			@end_date = end_date
			@dates = (start_date..end_date)
			
			raise ArgumentError.new("Invalid date range!") if @start_date > @end_date
		end

		def nights
			return @end_date - @start_date
		end

		def overlap?(other)
			return @start_date < other.end_date && @end_date > other.start_date
		end		
	end
end