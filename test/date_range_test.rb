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
      [:start_date, :end_date].each do |attribute|
        expect(@date_range).must_respond_to attribute
      end

      expect(@date_range.start_date).must_be_kind_of Date
			expect(@date_range.end_date).must_be_kind_of Date
		end
		
		it "throws an exception when an invalid date range is provided" do
			expect{ Hotel::DateRange.new(
				start_date: Date.new(2020,3,5),
				end_date: Date.new(2020,3,2)
			) }.must_raise ArgumentError
		end
	end

	describe "#nights" do
		it "returns an Integer" do
			expect(@date_range.nights).must_be_kind_of Integer
		end

		it "calculates the nights of stay accurately" do
			expect(@date_range.nights).must_equal 3
		end
	end

	describe "#overlap?" do
		before do
			@date_range2 = Hotel::DateRange.new(
				start_date: Date.new(2020,3,2),
				end_date: Date.new(2020,3,5)
			)
		end

		it "returns true when start_date and end_date are both within the range" do
			expect(@date_range.overlap?(@date_range2)).must_equal true
		end

		it "returns false when start_date and end_date are both outside the range" do
			@date_range2.start_date += 8
			@date_range2.end_date += 8
			expect(@date_range.overlap?(@date_range2)).must_equal false
		end

		it "returns true when start_date is within the range but end_date is outside the range" do
			@date_range2.start_date += 1
			@date_range2.end_date += 1
			expect(@date_range.overlap?(@date_range2)).must_equal true
		end

		it "returns true when the start_date is outside the range but end_date is within the range" do
			@date_range2.start_date -= 1
			@date_range2.end_date -= 1
			expect(@date_range.overlap?(@date_range2)).must_equal true
		end
		
		it "returns true when the start_date is equal to the end_date in the range" do
			@date_range2.start_date += 3
			@date_range2.end_date += 3
			expect(@date_range.overlap?(@date_range2)).must_equal true
		end

		it "returns true when the end_date is equal to the start_date in the range" do
			@date_range2.start_date -= 3
			@date_range2.end_date -= 3
			expect(@date_range.overlap?(@date_range2)).must_equal true
		end
	end

	describe "#include?" do
		it "returns true when the date given is at the start of the range" do
			date = Date.new(2020,3,2)
			expect(@date_range.include?(date)).must_equal true
		end

		it "returns true when the date given is at the end of the range" do
			date = Date.new(2020,3,5)
			expect(@date_range.include?(date)).must_equal true
		end

		it "returns true when the date given is in the middle of the range" do
			date = Date.new(2020,3,3)
			expect(@date_range.include?(date)).must_equal true
		end

		it "returns false when the date given is outside the range" do
			date = Date.new(2020,3,10)
			expect(@date_range.include?(date)).must_equal false
		end
	end
end
	