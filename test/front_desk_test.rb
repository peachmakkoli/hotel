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
	end

	describe "#reserve_room" do
		it "can reserve a room given a start date and an end date" do
			start_date = Date.new(2020,3,2)
			end_date = Date.new(2020,3,5)
			reservation = @front_desk.reserve_room(start_date, end_date)
			expect(reservation).must_be_kind_of Hotel::Reservation
		end
	end
end