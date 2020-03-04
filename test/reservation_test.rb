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

	describe "Reservation property" do
		
	end

	describe "#date_range" do
		before do
			@range = @reservation.date_range
		end

		it "returns an array with the correct length and start/end values" do
			expect(@range).must_be_kind_of Array
			expect(@range.length).must_equal 4
			expect(@range.first).must_equal @reservation.start_date
			expect(@range.last).must_equal @reservation.end_date
		end		

		it "returns all dates between the start and end dates" do
			expect(@range[1]).must_equal @reservation.start_date + 1
			expect(@range[2]).must_equal @reservation.start_date + 2
		end		
	end

	describe "#nights" do
		it "calculates the nights of stay accurately" do
			expect(@reservation.nights).must_equal 3
		end
	end

	describe "#overlap?" do
		before do
			@start_date = Date.new(2020,3,2)
			@end_date = Date.new(2020,3,5)
		end

		it "accurately checks whether dates overlap with date range when start_date and end_date are both within the range" do
			expect(@reservation.overlap?(@start_date, @end_date)).must_equal true
		end

		it "checks whether dates overlap with date range when start_date and end_date are both outside the range" do
			start_date = @start_date + 8
			end_date = @start_date + 8
			expect(@reservation.overlap?(start_date, end_date)).must_equal false
		end

		it "checks whether dates overlap with date range when start_date is within the range but end_date is outside the range" do
			start_date = @start_date + 1
			end_date = @start_date + 1
			expect(@reservation.overlap?(start_date, end_date)).must_equal true
		end

		it "checks whether dates overlap with date range when the start_date is outside the range but end_date is within the range" do
			start_date = @start_date - 1
			end_date = @start_date - 1
			expect(@reservation.overlap?(start_date, end_date)).must_equal true
		end

		it "ignores reservations whose start_date is equal to the end_date in the range (new check-ins can happen on the same day as check-outs)" do
			start_date = @start_date + 3
			end_date = @start_date + 3
			expect(@reservation.overlap?(start_date, end_date)).must_equal false
		end
	end

	describe "#total_cost" do
		it "calculates the total cost accurately" do
			expect(@reservation.total_cost).must_equal 600.0
		end
	end
end