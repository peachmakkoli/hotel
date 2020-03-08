require_relative 'reservation'

module Hotel
	class FrontDesk
		attr_reader :rooms, :reservations, :blocks

		def initialize
			@rooms = (1..20).to_a
			@reservations = []
			@blocks = []
		end

		def add_reservation(reservation)
			@reservations << reservation
		end

		def reserve_room(date_range)
			new_reservation = Hotel::Reservation.new(
				id: @reservations.length + 1,
				room: find_available_room(date_range).first,
				start_date: date_range.start_date,
				end_date: date_range.end_date
			)
			add_reservation(new_reservation)
			return new_reservation
		end

		def add_block(block)
			@blocks << block
		end

		def reserve_block(rooms, rate, date_range)
			rooms.each { |room| 
				raise ArgumentError.new("At least one of the rooms is unavailable for the given date range!") if !reservations_by_room(room, date_range).empty? 
			}
			
			new_block = Hotel::Block.new(
				id: @blocks.length + 1,
				rooms: rooms,
				rate: rate,
				start_date: date_range.start_date,
				end_date: date_range.end_date
			)
			add_block(new_block)

			# rooms.each { |room| 
			# 	new_reservation = Hotel::Reservation.new(
			# 		id: @reservations.length + 1,
			# 		room: room,
			# 		block: new_block.id,
			# 		start_date: date_range.start_date,
			# 		end_date: date_range.end_date
			# 	)
			# 	add_reservation(new_reservation)
			# }

			return new_block
		end
		
		def reservations_by_room(room, date_range)
			return @reservations.select { |reservation| 
				reservation.room == room && reservation.date_range.overlap?(date_range)
			}
		end

		def reservations_by_block(block_id, date_range)
			# Wave 3: I can see a reservation made from a hotel block from the list of reservations for that date (see wave 1 requirements)
		end

		def reservations_by_date(date)
			return @reservations.select { |reservation| 
				reservation.date_range.include?(date) 
			}
		end

		# SPACE COMPLEXITY!!!
		def find_available_room(date_range)
			return @rooms if @reservations == []
			# available_rooms = rooms.select { |room| 
			# 	room if reservations_by_room(room, date_range).empty? 
			# }
			available_rooms = @rooms.dup
			@reservations.each { |reservation| 
				available_rooms.delete(reservation.room) if reservation.date_range.overlap?(date_range) && reservation.date_range.start_date != date_range.end_date && reservation.date_range.end_date != date_range.start_date
			}
			raise ArgumentError.new("No rooms available for that date range!") if available_rooms == []
			return available_rooms		
		end
	end
end
