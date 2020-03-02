require_relative 'test_helper'

describe "FrontDesk class" do
	describe "FrontDesk instantiation" do
		before do 
			@front_desk = Hotel::FrontDesk.new
		end

		it "is an instance of FrontDesk" do
			expect(@front_desk).must_be_kind_of Hotel::FrontDesk
		end

		it "can access the list of all the rooms in the hotel" do
			expect(@front_desk.rooms).must_be_kind_of Array
			expect(@front_desk.rooms.first).must_equal 1
			expect(@front_desk.rooms.last).must_equal 20
		end
	end
end