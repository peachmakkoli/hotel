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
			available_rooms = find_available_room(start_date, end_date)
			raise ArgumentError.new("No rooms available for that date range!") if available_rooms == []
			
			new_reservation = Hotel::Reservation.new(
				id: @reservations.length + 1,
				room: available_rooms.first,
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

			available_rooms = @rooms.dup
			@reservations.each { |reservation| available_rooms.delete(reservation.room) if reservation.overlap?(range_start, range_end) }
			return available_rooms
		end
	end
end
