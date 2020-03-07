require_relative 'test_helper'

describe "Block class" do
	before do 
		rooms = (1..5).to_a
		@block = Hotel::Block.new(
			start_date: Date.new(2020,3,2),
			end_date: Date.new(2020,3,5),
			rooms: rooms,
			rate: 150.0
		)
	end

	describe "Block instantiation" do
		it "is an instance of Block" do
			expect(@block).must_be_kind_of Hotel::Block
		end
	end
end