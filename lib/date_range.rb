module Hotel
	class DateRange
		attr_accessor :start_date, :end_date

		def initialize(start_date:, end_date:)
			@start_date = start_date
			@end_date = end_date

			raise ArgumentError.new("Invalid date range!") if @start_date > @end_date
		end

		def nights
			return (@end_date - @start_date).to_i
		end

		def overlap?(other)
			return @start_date < other.end_date && @end_date > other.start_date
		end		

		def include?(date)
			low = 0
			high = self.nights
			
			return true if @start_date == date || @end_date == date

			while low <= high
				mid = (low + high) / 2
				if (@start_date + mid) == date
					return true
				elsif (@start_date + mid) > date
					high = mid - 1
				elsif (@start_date + mid) < date
					low = mid + 1
				end
			end
		
			return false
		end

		def each
			index = 0
			while index <= self.nights
				yield @start_date + index
				index += 1
			end
			# return (@start_date..@end_date).each
		end
	end
end