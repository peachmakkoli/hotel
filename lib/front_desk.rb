require_relative 'reservation'

module Hotel
	class FrontDesk
		attr_reader :rooms, :reservations

		def initialize
			@rooms = (1..20).to_a
			@reservations = []
		end

		def add_reservation(reservation)
			@reservations << reservation
		end

		def reserve_room(start_date, end_date)
			new_reservation = Hotel::Reservation.new(
				id: @reservations.length + 1,
				room: nil, # placeholder
				start_date: start_date,
				end_date: end_date
			)
			add_reservation(new_reservation)
			return new_reservation
		end

		def reservations_by_room(room, start_date, end_date)
			return @reservations.select { |reservation| reservation.room == room && reservation.date_range.include?(start_date) && reservation.date_range.include?(end_date) } 
		end

		# I can access the list of reservations for a specific date, so that I can track reservations by date
	end
end
