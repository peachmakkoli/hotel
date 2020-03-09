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
				raise ArgumentError.new("At least one of the rooms is unavailable for the given date range!") if !rooms.any? { |room| find_available_room(date_range).include?(room) }
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
			available_rooms = @rooms.dup
			@reservations.each { |reservation| 
				available_rooms.delete(reservation.room) if reservation.date_range.start_date < date_range.end_date && reservation.date_range.end_date > date_range.start_date
			}
			@blocks.each { |block| 
				(block.rooms).each { |room|
				available_rooms.delete(room)
				} if block.date_range.start_date < date_range.end_date && block.date_range.end_date > date_range.start_date
			}
			raise ArgumentError.new("No rooms available for that date range!") if available_rooms == []
			return available_rooms		
		end

			def find_block(id)
				raise ArgumentError.new("No blocks with the given ID!") if @blocks.none? { |block| block.id == id }
				return @blocks.find { |block| block.id == id }
			end

			# I can check whether a given block has any rooms available
			def find_available_room_in_block(id)
				# look up reservations that match the block id, exclude their rooms from the list of rooms it returns
			end

			# I can reserve a specific room from a hotel block
			# I can only reserve that room from a hotel block for the full duration of the block
			def reserve_room_in_block(id, room)
			# finds block by id
			# creates reservation for that room
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
			end
	end
end