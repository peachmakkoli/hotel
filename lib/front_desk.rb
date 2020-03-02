require_relative 'reservation'

module Hotel
	class FrontDesk
		attr_reader :rooms, :reservations

		def initialize
			@rooms = (1..20).to_a
			@reservations = []
		end

		def reserve_room(start_date, end_date)
			return Hotel::Reservation.new(
				id: @reservations.length + 1,
				room: nil, # placeholder
				start_date: start_date,
				end_date: end_date
			)
		end

		# I access the list of reservations for a specified room and a given date range
		
		# I can access the list of reservations for a specific date, so that I can track reservations by date
	end
end
