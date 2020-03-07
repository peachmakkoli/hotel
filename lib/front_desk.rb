require_relative 'reservation'
require_relative 'date_range'

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

		def reserve_room(date_range)
			available_rooms = find_available_room(date_range)
			raise ArgumentError.new("No rooms available for that date range!") if available_rooms == []
			
			new_reservation = Hotel::Reservation.new(
				id: @reservations.length + 1,
				room: available_rooms.first,
				start_date: date_range.start_date,
				end_date: date_range.end_date
			)
			add_reservation(new_reservation)
			
			return new_reservation
		end
		
		def reservations_by_room(room, date_range)
			return @reservations.select { |reservation| 
				reservation.room == room && reservation.date_range.overlap?(date_range)
			}
		end

		def reservations_by_date(date)
			return @reservations.select { |reservation| 
				reservation.date_range.include?(date) 
			}
		end

		def find_available_room(date_range)
			return @rooms if @reservations == []
			available_rooms = @rooms.dup
			@reservations.each { |reservation| 
				available_rooms.delete(reservation.room) if reservation.date_range.overlap?(date_range) && reservation.date_range.start_date != date_range.end_date && reservation.date_range.end_date != date_range.start_date 
			}
			return available_rooms
			# if a room class is added, this method can be simplified
			# return @rooms if @reservations == []
			# return @rooms.select { |room| room.num unless room.reservations.each { |reservation| reservation.date_range.overlap?(date_range) }
		end
	end
end
