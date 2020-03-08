require_relative 'test_helper'

describe "Block class" do
	before do 
		@block = Hotel::Block.new(
			id: 1,
			rooms: (1..5).to_a,
			rate: 150.0,
			start_date: Date.new(2020,3,2),
			end_date: Date.new(2020,3,5)
		)
	end

	describe "Block instantiation" do
		it "is an instance of Block" do
			expect(@block).must_be_kind_of Hotel::Block
		end

		it "is set up for specific attributes and data types" do
      [:id, :rooms, :rate, :date_range].each do |attribute|
        expect(@block).must_respond_to attribute
      end

			expect(@block.id).must_be_kind_of Integer
			expect(@block.rooms).must_be_kind_of Array
			expect(@block.rate).must_be_kind_of Float
			expect(@block.date_range).must_be_kind_of Hotel::DateRange
    end
		
		it "throws an exception if the list of rooms is greater than 5" do
			expect{ Hotel::Block.new(
				id: 1,
				rooms: (1..6).to_a,
				rate: 150.0,
				start_date: Date.new(2020,3,2),
				end_date: Date.new(2020,3,5)
			) }.must_raise ArgumentError
		end

		it "throws an exception if the list of rooms is less than 2" do
			expect{ Hotel::Block.new(
				id: 1,
				rooms: [1],
				rate: 150.0,
				start_date: Date.new(2020,3,2),
				end_date: Date.new(2020,3,5)
			) }.must_raise ArgumentError
		end
	end
end