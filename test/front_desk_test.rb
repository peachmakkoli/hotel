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

	describe "#reserve_room" do
		before do
			start_date = Date.new(2020,3,2)
			end_date = Date.new(2020,3,5)
			@reservation1 = @front_desk.reserve_room(start_date, end_date)
			@reservation2 = @front_desk.reserve_room(start_date + 5, end_date + 5)
			@reservation3 = @front_desk.reserve_room(start_date + 10, end_date + 10)
		end

		it "can reserve a room given a start date and an end date" do
			expect(@reservation1).must_be_kind_of Hotel::Reservation
		end

		it "throws an exception if there are no rooms available" do
			@front_desk.rooms.clear
			expect(@front_desk.rooms.length).must_equal 0 
			expect{@front_desk.reserve_room(Date.new(2020,3,2), Date.new(2020,3,5))}.must_raise ArgumentError
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

			@selected_reservations = @front_desk.reservations_by_room(15, Date.new(2020,3,2), Date.new(2020,3,5))
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
				room: 3,
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
			
			@available_rooms = @front_desk.find_available_room(Date.new(2020,3,2), Date.new(2020,3,5))
		end

		it "returns an array of valid room numbers" do
			expect(@available_rooms).must_be_kind_of Array
			expect(@available_rooms.first).must_be_kind_of Integer
			expect(@front_desk.rooms).must_include @available_rooms.first
			expect(@front_desk.rooms).must_include @available_rooms.last
		end

		it "returns a list of rooms that are not reserved for a given date range" do
			expect(@available_rooms.length).must_equal 18
			expect(@available_rooms).must_include 15
			expect(@available_rooms).must_include 3
		end

		it "returns all rooms if there are no Reservations" do
			@front_desk.reservations.clear
			available_rooms = @front_desk.find_available_room(Date.new(2020,3,2), Date.new(2020,3,5))
			expect(@front_desk.reservations.length).must_equal 0 
			expect(available_rooms).must_equal @front_desk.rooms
		end
	end
end