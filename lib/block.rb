require 'date'
require_relative 'date_range'

module Hotel
	class Block 
		attr_reader :date_range, :rooms, :rate

		def initialize(start_date:, end_date:, rooms:, rate:)
			# I can create a Hotel Block if I give a date range, collection of rooms, and a discounted room rate
		end

	end
end