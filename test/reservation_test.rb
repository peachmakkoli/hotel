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

		it "is set up for specific attributes and data types" do
      [:id, :room, :date_range].each do |attribute|
        expect(@reservation).must_respond_to attribute
      end

      expect(@reservation.id).must_be_kind_of Integer
			expect(@reservation.room).must_be_kind_of Integer
			expect(@reservation.date_range).must_be_kind_of Hotel::DateRange
    end
	end

	describe "#total_cost" do
		it "accurately calculates the total cost for single rooms" do
			expect(@reservation.total_cost).must_equal 600.0
		end
	end
end