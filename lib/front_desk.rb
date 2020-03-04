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
				room: @rooms.sample, # placeholder
				start_date: start_date,
				end_date: end_date
			)
			add_reservation(new_reservation)
			return new_reservation
		end

		def reservations_by_room(room, start_date, end_date)
			# return @reservations.select { |reservation| reservation.room == room && reservation.date_range.include?(start_date) || reservation.date_range.include?(end_date) }
			return @reservations.select { |reservation| reservation.room == room && reservation.start_date >= start_date && reservation.start_date <= end_date }
		end

		def reservations_by_date(date)
			return @reservations.select { |reservation| reservation.start_date == date }
		end

		# I can view a list of rooms that are not reserved for a given date range, so that I can see all available rooms for that day

		# I can make a reservation of a room for a given date range, and that room will not be part of any other reservation overlapping that date range

		# I want an exception raised if I try to reserve a room during a date range when all rooms are reserved, so that I cannot make two reservations for the same room that overlap by date
	end
end
