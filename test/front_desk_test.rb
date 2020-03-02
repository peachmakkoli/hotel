require_relative 'test_helper'

describe "FrontDesk class" do
	describe "FrontDesk instantiation" do
		before do 
			@front_desk = Hotel::FrontDesk.new
		end

		it "is an instance of FrontDesk" do
			expect(@front_desk).must_be_kind_of Hotel::FrontDesk
		end

	end
end