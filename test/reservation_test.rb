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
      [:id, :room, :block, :rate, :date_range].each do |attribute|
        expect(@reservation).must_respond_to attribute
      end

      expect(@reservation.id).must_be_kind_of Integer
			expect(@reservation.room).must_be_kind_of Integer
			expect(@reservation.block).must_equal false
			expect(@reservation.rate).must_be_kind_of Float
			expect(@reservation.date_range).must_be_kind_of Hotel::DateRange
		end
		
		it "throws an exception if the custom rate cannot be converted to a float" do
			expect{Hotel::Reservation.new(
				id: 1,
				room: 15,
				rate: "a",
				start_date: Date.new(2020,3,2),
				end_date: Date.new(2020,3,5)
			)}.must_raise ArgumentError
		end
	end

	describe "#total_cost" do
		it "accurately calculates the total cost for single rooms with the default rate" do
			expect(@reservation.total_cost).must_equal 600.0
		end

		it "accurately calculates the total cost for a room reserved from a hotel block" do
			@front_desk = Hotel::FrontDesk.new
			block = Hotel::Block.new(
				id: 1,
				rooms: (1..5).to_a,
				rate: 150.0,
				start_date: Date.new(2020,3,2),
				end_date: Date.new(2020,3,5)
			)
			@front_desk.add_block(block)

			reservation = @front_desk.reserve_room_in_block(1, 1)
			
			expect(reservation.total_cost).must_equal 450.0
		end
	end
end