require_relative 'test_helper'

describe "Block class" do
	before do 
		rooms = (1..5).to_a
		@block = Hotel::Block.new(
			rooms: rooms,
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
      [:rooms, :rate, :date_range].each do |attribute|
        expect(@block).must_respond_to attribute
      end

			expect(@block.rooms).must_be_kind_of Array
			expect(@block.rate).must_be_kind_of Float
			expect(@block.date_range).must_be_kind_of Hotel::DateRange
    end
	end
end