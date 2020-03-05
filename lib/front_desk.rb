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

		# use less than/greater than instead of include? method to lower complexity
		def reservations_by_room(room, range_start, range_end)
			return @reservations.select { |reservation| 
				reservation.room == room && reservation.start_date <= range_end && reservation.end_date >= range_start 
			}
		end

		def reservations_by_date(date)
			return @reservations.select { |reservation| 
				reservation.date_range.include?(date) 
			}
		end

		def find_available_room(range_start, range_end)
			return @rooms if @reservations == []

			@reservations.each { |reservation| @rooms.delete(reservation.room) if reservation.overlap?(range_start, range_end) }
			return @rooms
		end

		# I can make a reservation of a room for a given date range, and that room will not be part of any other reservation overlapping that date range

		# I want an exception raised if I try to reserve a room during a date range when all rooms are reserved, so that I cannot make two reservations for the same room that overlap by date
	end
end
