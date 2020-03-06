require_relative 'test_helper'

describe "DateRange class" do
	before do 
		@date_range = Hotel::DateRange.new(
			start_date: Date.new(2020,3,2),
			end_date: Date.new(2020,3,5)
		)
	end

	describe "DateRange instantiation" do
		it "is an instance of DateRange" do
			expect(@reservation).must_be_kind_of Hotel::Reservation
		end

		it "is set up for specific attributes and data types" do
      [:start_date, :end_date].each do |attribute|
        expect(@reservation).must_respond_to attribute
      end

      expect(@reservation.start_date).must_be_kind_of Date
      expect(@reservation.end_date).must_be_kind_of Date
		end
		
		it "throws an exception when an invalid date range is provided" do
			expect{ Hotel::DateRange.new(
				start_date: Date.new(2020,3,5),
				end_date: Date.new(2020,3,2)
			) }.must_raise ArgumentError
		end
	end
	