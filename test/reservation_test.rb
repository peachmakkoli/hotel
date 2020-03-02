require_relative 'test_helper'

describe "Reservation class" do
	describe "Reservation instantiation" do
		before do 
			@reservation = Hotel::Reservation.new(
				id: 1,
				start_date: "March 2 2020",
				end_date: "March 5 2020"
			)
		end

		it "is an instance of Reservation" do
			expect(@reservation).must_be_kind_of Hotel::Reservation
		end

	end
end