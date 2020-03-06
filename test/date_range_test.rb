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
			expect(@date_range).must_be_kind_of Hotel::DateRange
		end

		it "is set up for specific attributes and data types" do
      [:start_date, :end_date, :dates].each do |attribute|
        expect(@date_range).must_respond_to attribute
      end

      expect(@date_range.start_date).must_be_kind_of Date
			expect(@date_range.end_date).must_be_kind_of Date
			expect(@date_range.dates).must_be_kind_of Range
		end
		
		it "throws an exception when an invalid date range is provided" do
			expect{ Hotel::DateRange.new(
				start_date: Date.new(2020,3,5),
				end_date: Date.new(2020,3,2)
			) }.must_raise ArgumentError
		end
	end

	describe "#nights" do
		it "calculates the nights of stay accurately" do
			expect(@date_range.nights).must_equal 3
		end
	end
end
	