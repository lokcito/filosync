require 'rails_helper'

RSpec.describe Contact, type: :model do
  before(:each) do
		@user = User.create(
			email: 'test@example.com', 
			password: 'password123',
			password_confirmation: 'password123'
		)
    @dateFile = DataFile.new
    @dateFile.columns = "name|email|phone|address|dateofbirth|franchise|creditcard"
    @dateFile.filename = "test.csv"
    @dateFile.users_id = @user.id
    @dateFile.save
    
    @contact = Contact.new
  end
  context "When we want to create" do
		it "Should not be valid without data" do
		  expect(@contact.valid?).to eq false
		end
		it "Should be valid with data" do
		  @contact.email = "aaa@aaa.com"
		  @contact.name = "test"
		  @contact.franchise = "MasterCard"
		  @contact.credit_card = "5555555555554444"
		  @contact.phone = "(+00) 000 000 00 00 00"
		  @contact.address = "test"
		  @contact.date_of_birth = "2021-12-21"
		  @contact.data_files_id = @dateFile.id
		  expect(@contact.valid?).to eq true
		end
	end
	context "When we want record dates" do 
		before(:each) do 
		  @contact.email = "aaa@aaa.com"
		  @contact.name = "test"
		  @contact.phone = "(+00) 000 000 00 00 00"
		  @contact.address = "test"
		  @contact.franchise = "MasterCard"
		  @contact.credit_card = "5555555555554444"
		  @contact.data_files_id = @dateFile.id
		end
		it "Accepts ISO 8601" do 
			@contact.date_of_birth = "2021-12-22"
			expect(@contact.valid?).to eq true
		end
		it "Does not accepts day month" do 
			@contact.date_of_birth = "21-12"
			expect(@contact.valid?).to eq false
		end
	end
	context "When we want record different credit cards" do 
		before(:each) do 
		  @contact.email = "aaa@aaa.com"
		  @contact.name = "test"
		  @contact.phone = "(+00) 000 000 00 00 00"
		  @contact.address = "test"
		  @contact.date_of_birth = "2021-12-21"
		  @contact.data_files_id = @dateFile.id
		end
		it "Match MasterCard" do 
		  @contact.franchise = "MasterCard"
		  @contact.credit_card = "5555555555554444"
		  expect(@contact.valid?).to eq true
		end
		it "Does not Match MasterCard" do 
		  @contact.franchise = "Visa"
		  @contact.credit_card = "5555555555554444"
		  expect(@contact.valid?).to eq false
		end
	end
end
