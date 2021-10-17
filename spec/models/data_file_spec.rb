require 'rails_helper'

RSpec.describe DataFile, type: :model do
  before(:each) do
		@user = User.create(
			email: 'test@example.com', 
			password: 'password123',
			password_confirmation: 'password123'
		)
    @dateFile = DataFile.new
  end
  context "When we want to create" do
		it "Should not be valid without data" do
		  expect(@dateFile.valid?).to eq false
		end
		it "Should be valid with filename" do
		  @dateFile.filename = "test.csv"
		  @dateFile.columns = "name|email|phone|address|dateofbirth|franchise|creditcard"
		  @dateFile.users_id = @user.id
		  expect(@dateFile.valid?).to eq true
		  
		end
	end
	context "When we've create a DataFile" do
		before(:each) do 
			@dateFile = DataFile._create({
				filename: "test.csv",
				columns: "name|email|phone|address|dateofbirth|franchise|creditcard",
				user_id: @user.id
			})[:object]
		end
		it "Should have status on hold" do 
			expect(@dateFile.status).to eq "hold"
		end
	end
end
