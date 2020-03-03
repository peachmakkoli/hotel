require_relative 'test_helper'

describe "Reservation class" do
	before do 
		@reservation = Hotel::Reservation.new(
			id: 1,
			room: 15,
			start_date: Date.new(2020,3,2),
			end_date: Date.new(2020,3,5)
		)
	end

	describe "Reservation instantiation" do
		it "is an instance of Reservation" do
			expect(@reservation).must_be_kind_of Hotel::Reservation
		end

		it "throws an exception when an invalid date range is provided" do
			expect{ Hotel::Reservation.new(
				id: 1,
				room: 15,
				start_date: Date.new(2020,3,5),
				end_date: Date.new(2020,3,2)
			) }.must_raise ArgumentError
		end
	end

	describe "#nights" do
		it "calculates the nights of stay accurately" do
			expect(@reservation.nights).must_equal 3
		end
	end

	describe "#total_cost" do
		it "calculates the total cost accurately" do
			expect(@reservation.total_cost).must_equal 600.0
		end
	end
end