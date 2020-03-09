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
			unavailable_rooms = @reservations.map { |reservation| 
				reservation.room if reservation.date_range.start_date < date_range.end_date && reservation.date_range.end_date > date_range.start_date
			}
			@blocks.each { |block| 
				(block.rooms).each { |room| unavailable_rooms << room } if block.date_range.start_date < date_range.end_date && block.date_range.end_date > date_range.start_date
			} # This method is very expensive. See refactors.txt for details.
			available_rooms = @rooms - unavailable_rooms

			raise ArgumentError.new("No rooms available for that date range!") if available_rooms.empty?		
			return available_rooms		
		end

		def reserve_room(date_range, rate = 200.0)
			new_reservation = Hotel::Reservation.new(
				id: @reservations.length + 1,
				room: find_available_room(date_range).first, 
				rate: rate.to_f,
				start_date: date_range.start_date,
				end_date: date_range.end_date
			)
			add_reservation(new_reservation)	
			return new_reservation
		end

		def add_block(block)
			@blocks << block
		end

		def find_block(id)
			block = @blocks.find { |block| block.id == id }
			raise ArgumentError.new("No blocks with the given ID!") if block.nil?
			return block
		end

		def reserve_block(rooms, rate, date_range)
			rooms.each { |room|
				raise ArgumentError.new("At least one of the rooms is unavailable for the given date range!") if !find_available_room(date_range).include?(room) 
			}
						
			new_block = Hotel::Block.new(
				id: @blocks.length + 1,
				rooms: rooms,
				rate: rate,
				start_date: date_range.start_date,
				end_date: date_range.end_date
			)
			add_block(new_block)
			return new_block
		end
		
		def find_available_room_in_block(id)
			block = find_block(id)
			unavailable_rooms = @reservations.map { |reservation| 
				reservation.room if reservation.block == block.id 
			}
			available_rooms = block.rooms - unavailable_rooms
			
			raise ArgumentError.new("No rooms available in the given block!") if available_rooms.empty?
			return available_rooms
		end

		def reserve_room_in_block(id, room)
			block = find_block(id)
			new_reservation = Hotel::Reservation.new(
				id: @reservations.length + 1,
				room: room,
				block: block.id,
				rate: block.rate,
				start_date: block.date_range.start_date,
				end_date: block.date_range.end_date
			)
			add_reservation(new_reservation)
			return new_reservation
		end
	end
end