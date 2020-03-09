require_relative 'test_helper'

describe "FrontDesk class" do
	before do 
		@front_desk = Hotel::FrontDesk.new
	end

	describe "FrontDesk instantiation" do
		it "is an instance of FrontDesk" do
			expect(@front_desk).must_be_kind_of Hotel::FrontDesk
		end

		it "can access the list of all the rooms in the hotel" do
			rooms = @front_desk.rooms

			expect(rooms).must_be_kind_of Array
			expect(rooms.first).must_equal 1
			expect(rooms.last).must_equal 20
		end

		it "can access the list of all reservations" do
			reservations = @front_desk.reservations

			expect(reservations).must_be_kind_of Array
		end

		it "can access the list of all blocks" do
			blocks = @front_desk.blocks
			
			expect(blocks).must_be_kind_of Array
		end
	end

	describe "#add_reservation" do
		it "adds the reservation passed in to the reservations array" do
			reservation = Hotel::Reservation.new(
				id: 1,
				room: 15,
				start_date: Date.new(2020,3,2),
				end_date: Date.new(2020,3,5)
			)
			before_length = @front_desk.reservations.length
			@front_desk.add_reservation(reservation)
			after_length = @front_desk.reservations.length

			expect(@front_desk.reservations.last).must_be_kind_of Hotel::Reservation
			expect(before_length).must_equal 0
			expect(after_length).must_equal 1
		end
	end

	describe "#reservations_by_room" do
		before do
			@reservation1 = Hotel::Reservation.new(
				id: 1,
				room: 15,
				start_date: Date.new(2020,3,2),
				end_date: Date.new(2020,3,5)
			)
			@reservation2 = Hotel::Reservation.new(
				id: 2,
				room: 20,
				start_date: Date.new(2020,3,3),
				end_date: Date.new(2020,3,4)
			)
			@reservation3 = Hotel::Reservation.new(
				id: 3,
				room: 15,
				start_date: Date.new(2020,3,5),
				end_date: Date.new(2020,3,10)
			)
			@reservation4 = Hotel::Reservation.new(
				id: 4,
				room: 15,
				start_date: Date.new(2020,3,1),
				end_date: Date.new(2020,3,2)
			)
			@front_desk.add_reservation(@reservation1)
			@front_desk.add_reservation(@reservation2)
			@front_desk.add_reservation(@reservation3)
			@front_desk.add_reservation(@reservation4)

			date_range = Hotel::DateRange.new(
				start_date: Date.new(2020,3,2), 
				end_date: Date.new(2020,3,5)
			)
			@selected_reservations = @front_desk.reservations_by_room(15, date_range)
		end

		it "returns an array of Reservations" do
			expect(@selected_reservations).must_be_kind_of Array
			expect(@selected_reservations.first).must_be_kind_of Hotel::Reservation
		end

		it "can access the list of reservations for a specified room and a given date range" do
			expect(@front_desk.reservations.length).must_equal 4 # ensure that the method isn't just returning the @reservations array
			expect(@selected_reservations.length).must_equal 3
			expect(@selected_reservations.first).must_equal @reservation1
			expect(@selected_reservations.last).must_equal @reservation4
		end
	end

	describe "#reservations_by_date" do
		before do
			@reservation1 = Hotel::Reservation.new(
				id: 1,
				room: 15,
				start_date: Date.new(2020,3,2),
				end_date: Date.new(2020,3,5)
			)
			@reservation2 = Hotel::Reservation.new(
				id: 2,
				room: 20,
				start_date: Date.new(2020,3,1),
				end_date: Date.new(2020,3,4)
			)
			@reservation3 = Hotel::Reservation.new(
				id: 3,
				room: 15,
				start_date: Date.new(2020,3,5),
				end_date: Date.new(2020,3,10)
			)
			@front_desk.add_reservation(@reservation1)
			@front_desk.add_reservation(@reservation2)
			@front_desk.add_reservation(@reservation3)

			@selected_reservations = @front_desk.reservations_by_date(Date.new(2020,3,2))
		end
	
		it "returns an array of Reservations" do
			expect(@selected_reservations).must_be_kind_of Array
			expect(@selected_reservations.first).must_be_kind_of Hotel::Reservation
		end

		it "can access the list of reservations for a specific date" do
			expect(@front_desk.reservations.length).must_equal 3 # ensure that the method isn't just returning the @reservations array
			expect(@selected_reservations.length).must_equal 2
			expect(@selected_reservations.first).must_equal @reservation1
			expect(@selected_reservations.last).must_equal @reservation2
		end

		it "can see a reservation made from a hotel block for a specific date" do
			block = Hotel::Block.new(
				id: 1,
				rooms: (1..5).to_a,
				rate: 150.0,
				start_date: Date.new(2020,3,2),
				end_date: Date.new(2020,3,5)
			) 
			@front_desk.add_block(block)
			reservation = @front_desk.reserve_room_in_block(1, 1)
			@selected_reservations = @front_desk.reservations_by_date(Date.new(2020,3,2))

			expect(@selected_reservations).must_include reservation
		end
	end

	describe "#find_available_room" do
		before do
			@reservation1 = Hotel::Reservation.new(
				id: 1,
				room: 15,
				start_date: Date.new(2020,2,27),
				end_date: Date.new(2020,3,2)
			)
			@reservation2 = Hotel::Reservation.new(
				id: 2,
				room: 20,
				start_date: Date.new(2020,3,1),
				end_date: Date.new(2020,3,4)
			)
			@reservation3 = Hotel::Reservation.new(
				id: 3,
				room: 6,
				start_date: Date.new(2020,3,5),
				end_date: Date.new(2020,3,10)
			)
			@reservation4 = Hotel::Reservation.new(
				id: 4,
				room: 9,
				start_date: Date.new(2020,3,4),
				end_date: Date.new(2020,3,10)
			)
			@front_desk.add_reservation(@reservation1)
			@front_desk.add_reservation(@reservation2)
			@front_desk.add_reservation(@reservation3)
			@front_desk.add_reservation(@reservation4)
			
			rooms = (1..5).to_a
			rate = 150.0
			@date_range = Hotel::DateRange.new(
				start_date: Date.new(2020,3,2), 
				end_date: Date.new(2020,3,5)
			)
			@block = @front_desk.reserve_block(rooms, rate, @date_range)
			
			@available_rooms = @front_desk.find_available_room(@date_range)
		end

		it "returns an array of valid room numbers" do
			expect(@available_rooms).must_be_kind_of Array
			expect(@available_rooms.first).must_be_kind_of Integer
			expect(@front_desk.rooms).must_include @available_rooms.first
			expect(@front_desk.rooms).must_include @available_rooms.last
		end

		it "returns a list of rooms that are not reserved for a given date range" do
			expect(@available_rooms.length).must_equal 13
			expect(@available_rooms).must_include 15
			expect(@available_rooms).must_include 6
		end

		it "returns all rooms if there are no reservations and no blocks" do
			@front_desk.reservations.clear
			@front_desk.blocks.clear
			available_rooms = @front_desk.find_available_room(@date_range)

			expect(@front_desk.reservations.length).must_equal 0 
			expect(@front_desk.blocks.length).must_equal 0 
			expect(available_rooms).must_equal @front_desk.rooms
		end

		it "throws an exception if there are no rooms available" do
			@front_desk.rooms.clear
			date_range = Hotel::DateRange.new(
				start_date: Date.new(2020,3,2), 
				end_date: Date.new(2020,3,5)
			)

			expect(@front_desk.rooms.length).must_equal 0 
			expect{@front_desk.find_available_room(date_range)}.must_raise ArgumentError
		end
	end

	describe "#reserve_room" do
		before do
			date_range1 = Hotel::DateRange.new(
				start_date: Date.new(2020,3,2), 
				end_date: Date.new(2020,3,5)
			)
			date_range2 = Hotel::DateRange.new(
				start_date: Date.new(2020,3,7), 
				end_date: Date.new(2020,3,10)
			)
			date_range3 = Hotel::DateRange.new(
				start_date: Date.new(2020,3,12), 
				end_date: Date.new(2020,3,15)
			)
			@reservation1 = @front_desk.reserve_room(date_range1)
			@reservation2 = @front_desk.reserve_room(date_range2)
			@reservation3 = @front_desk.reserve_room(date_range3)
		end

		it "can reserve a room given a start date and an end date" do
			expect(@reservation1).must_be_kind_of Hotel::Reservation
		end

		it "can set different rates for different rooms" do
			date_range4 = Hotel::DateRange.new(
				start_date: Date.new(2020,3,2), 
				end_date: Date.new(2020,3,5)
			)
			reservation4 = @front_desk.reserve_room(date_range4, 300.0)

			expect(reservation4.rate).must_equal 300.0
		end

		it "assigns a unique id number to each Reservation" do
			expect(@reservation1.id).must_equal 1
			expect(@reservation2.id).must_equal 2
			expect(@reservation3.id).must_equal 3
		end

		it "assigns a valid room number" do
			expect(@front_desk.rooms).must_include @reservation1.room
			expect(@front_desk.rooms).must_include @reservation2.room
			expect(@front_desk.rooms).must_include @reservation3.room
		end

		it "adds the new reservations to the reservations array" do
			expect(@front_desk.reservations.length).must_equal 3
			expect(@front_desk.reservations.first).must_equal @reservation1
			expect(@front_desk.reservations.last).must_equal @reservation3
		end
	end

	describe "#add_block" do
		it "adds the block passed in to the blocks array" do
			block = Hotel::Block.new(
				id: 1,
				rooms: (1..5).to_a,
				rate: 150.0,
				start_date: Date.new(2020,3,2),
				end_date: Date.new(2020,3,5)
			)
			before_length = @front_desk.blocks.length
			@front_desk.add_block(block)
			after_length = @front_desk.blocks.length
			
			expect(@front_desk.blocks.last).must_be_kind_of Hotel::Block
			expect(before_length).must_equal 0
			expect(after_length).must_equal 1
		end
	end

	describe "find_block" do
		before do
			@block1 = Hotel::Block.new(
				id: 1,
				rooms: (1..5).to_a,
				rate: 150.0,
				start_date: Date.new(2020,3,2),
				end_date: Date.new(2020,3,5)
			) 
			@block2 = Hotel::Block.new(
				id: 2,
				rooms: (6..10).to_a,
				rate: 150.0,
				start_date: Date.new(2020,3,2),
				end_date: Date.new(2020,3,5)
			) 
			@front_desk.add_block(@block1)
			@front_desk.add_block(@block2)
		end

		it "throws an exception if no Blocks match id given" do
			expect{@front_desk.find_block(3)}.must_raise ArgumentError
		end

		it "returns the correct block" do
			expect(@front_desk.find_block(2)).must_equal @block2
		end
	end

	describe "#reserve_block" do
		before do
			rooms = (1..5).to_a
			rate = 150.0
			date_range = Hotel::DateRange.new(
				start_date: Date.new(2020,3,2), 
				end_date: Date.new(2020,3,5)
			)
			@block = @front_desk.reserve_block(rooms, rate, date_range)
		end

		it "can reserve a block given a collection of rooms, a discounted room rate, and a date range" do
			expect(@block).must_be_kind_of Hotel::Block
		end

		it "throws an exception if at least one of the rooms is unavailable for the given date range" do	
			rooms = (6..10).to_a
			rate = 150.0
			date_range = Hotel::DateRange.new(
				start_date: Date.new(2020,3,2), 
				end_date: Date.new(2020,3,5)
			)
			reservation = Hotel::Reservation.new(
				id: 1,
				room: 6,
				start_date: Date.new(2020,3,2),
				end_date: Date.new(2020,3,5)
			)
			@front_desk.add_reservation(reservation)
			
			expect{@front_desk.reserve_block(rooms, rate, date_range)}.must_raise ArgumentError
		end

		it "throws an exception if at least one of the rooms can be found in an existing hotel block for the given date range" do	
			rooms = (5..9).to_a
			rate = 150.0
			date_range = Hotel::DateRange.new(
				start_date: Date.new(2020,3,2), 
				end_date: Date.new(2020,3,5)
			)
			
			expect{@front_desk.reserve_block(rooms, rate, date_range)}.must_raise ArgumentError
		end

		it "adds the new Block to the blocks array" do
			expect(@front_desk.blocks.length).must_equal 1
			expect(@front_desk.blocks.first).must_equal @block
		end
	end

	describe "#find_available_room_in_block" do
		before do
			@block = Hotel::Block.new(
				id: 1,
				rooms: (1..5).to_a,
				rate: 150.0,
				start_date: Date.new(2020,3,2),
				end_date: Date.new(2020,3,5)
			)
			@front_desk.add_block(@block)

			@reservation = Hotel::Reservation.new(
				id: 1,
				room: 1,
				block: 1,
				rate: 150.0,
				start_date: Date.new(2020,3,2),
				end_date: Date.new(2020,3,5)
			)
			@front_desk.add_reservation(@reservation)

			@available_rooms = @front_desk.find_available_room_in_block(1)
		end

		it "returns an array of valid room numbers" do
			expect(@available_rooms).must_be_kind_of Array
			expect(@available_rooms.first).must_be_kind_of Integer
			expect(@block.rooms).must_include @available_rooms.first
			expect(@block.rooms).must_include @available_rooms.last
		end

		it "returns a list of rooms that are not reserved for a given date range" do
			expect(@available_rooms.length).must_equal 4
			expect(@available_rooms).wont_include 1
		end

		it "returns all rooms if there are no Reservations with the given block id" do
			@front_desk.reservations.clear
			available_rooms = @front_desk.find_available_room_in_block(1)
			
			expect(@front_desk.reservations.length).must_equal 0 
			expect(available_rooms).must_equal @block.rooms
		end

		it "throws an exception if there are no rooms available" do
			reservation2 = Hotel::Reservation.new(
				id: 2,
				room: 2,
				block: 1,
				rate: 150.0,
				start_date: Date.new(2020,3,2),
				end_date: Date.new(2020,3,5)
			)
			reservation3 = Hotel::Reservation.new(
				id: 3,
				room: 3,
				block: 1,
				rate: 150.0,
				start_date: Date.new(2020,3,2),
				end_date: Date.new(2020,3,5)
			)
			reservation4 = Hotel::Reservation.new(
				id: 4,
				room: 4,
				block: 1,
				rate: 150.0,
				start_date: Date.new(2020,3,2),
				end_date: Date.new(2020,3,5)
			)
			reservation5 = Hotel::Reservation.new(
				id: 5,
				room: 5,
				block: 1,
				rate: 150.0,
				start_date: Date.new(2020,3,2),
				end_date: Date.new(2020,3,5)
			)
			@front_desk.add_reservation(reservation2)
			@front_desk.add_reservation(reservation3)
			@front_desk.add_reservation(reservation4)
			@front_desk.add_reservation(reservation5)

			expect(@front_desk.reservations.length).must_equal 5 
			expect{@front_desk.find_available_room_in_block(1)}.must_raise ArgumentError
		end
	end

	describe "#reserve_room_in_block" do
		before do
			@block = Hotel::Block.new(
				id: 1,
				rooms: (1..5).to_a,
				rate: 150.0,
				start_date: Date.new(2020,3,2),
				end_date: Date.new(2020,3,5)
			)
			@front_desk.add_block(@block)

			@reservation1 = Hotel::Reservation.new(
				id: 1,
				room: 1,
				block: 1,
				rate: 150.0,
				start_date: Date.new(2020,3,2),
				end_date: Date.new(2020,3,5)
			)
			@front_desk.add_reservation(@reservation1)

			@reservation2 = @front_desk.reserve_room_in_block(1, 2)
		end

		it "can reserve a specific room from a hotel block" do
			expect(@reservation2).must_be_kind_of Hotel::Reservation
			expect(@block.rooms).must_include @reservation2.room
		end

		it "assigns a unique id number to the new reservation" do
			expect(@reservation2.id).must_equal 2
		end

		it "adds the new reservation to the reservations array" do
			expect(@front_desk.reservations.length).must_equal 2
			expect(@front_desk.reservations.first).must_equal @reservation1
			expect(@front_desk.reservations.last).must_equal @reservation2
		end
	end
end