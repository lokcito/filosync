require 'rails_helper'

RSpec.describe "DataFile", type: :request do
  describe "POST create" do
    before(:each) do
			@user = User.create(
				email: 'test@example.com', 
				password: 'password123',
				password_confirmation: 'password123'
			)
      sign_in @user
    end
		it "returns http success" do
		  post "/data_file.json", params: {
		  	columns: "name|email|phone|address|dateofbirth|franchise|creditcard",
				csv_file: Rack::Test::UploadedFile
					.new("#{Rails
						.root.join('spec', 
							'requests', 'csvs', 'data.csv')}")
		  }
		  expect(response).to have_http_status(:success)
		  expect(DataFile.all.count).to eq 1
		  expect(DataFile.first.status).to eq "hold"
		end
		it "returns http bad" do
		  post "/data_file.json", params: {
		  	columns: "name|phone|address|dateofbirth|franchise|creditcard",
				csv_file: Rack::Test::UploadedFile
					.new("#{Rails
						.root.join('spec', 
							'requests', 'csvs', 'data.csv')}")
		  }
		  expect(response).to have_http_status(401)
		  expect(DataFile.all.count).to eq 0
		end
		it "returns http bad" do
		  post "/data_file.json", params: {
		  	columns: "test|name|phone|address|dateofbirth|franchise|creditcard",
				csv_file: Rack::Test::UploadedFile
					.new("#{Rails
						.root.join('spec', 
							'requests', 'csvs', 'data.csv')}")
		  }
		  expect(response).to have_http_status(401)
		  expect(DataFile.all.count).to eq 0
		end
		context "When I want sync the file" do 
			before(:each) do 
				sleep 1 # Wait for a 1 second
			  post "/data_file.json", params: {
			  	columns: "name|email|phone|address|dateofbirth|franchise|creditcard",
					csv_file: Rack::Test::UploadedFile
						.new("#{Rails
							.root.join('spec', 
								'requests', 'csvs', 'data.csv')}")
			  }
			end
			it "Should record 2 rows" do 
				expect(DataFile.all.count).to eq 1
				DataFile.first.sync
				expect(Contact.where(data_files: DataFile.first).count).to eq 2
				expect(IssueFile.where(data_files: DataFile.first).count).to eq 1
				expect(IssueFile.where(data_files: DataFile.first).first.line).to eq 1
				expect(DataFile.first.status).to eq "finished"
			end
		end
		context "When I want sync the an empty file" do 
			before(:each) do 
				sleep 1 # Wait for a 1 second
			  post "/data_file.json", params: {
			  	columns: "name|email|phone|address|dateofbirth|franchise|creditcard",
					csv_file: Rack::Test::UploadedFile
						.new("#{Rails
							.root.join('spec', 
								'requests', 'csvs', 'empty.csv')}")
			  }
			end
			it "Should record 0 rows" do 
				expect(DataFile.all.count).to eq 1
				DataFile.first.sync
				expect(Contact.where(data_files: DataFile.first).count).to eq 0
				expect(IssueFile.where(data_files: DataFile.first).count).to eq 0
				expect(DataFile.first.status).to eq "finished"
			end
		end
		context "When I want sync the a file with errors" do 
			before(:each) do 
				sleep 1 # Wait for a 1 second
			  post "/data_file.json", params: {
			  	columns: "name|email|phone|address|dateofbirth|franchise|creditcard",
					csv_file: Rack::Test::UploadedFile
						.new("#{Rails
							.root.join('spec', 
								'requests', 'csvs', 'errors.csv')}")
			  }
			end
			it "Should record 0 rows" do 
				expect(DataFile.all.count).to eq 1
				DataFile.first.sync
				expect(Contact.where(data_files: DataFile.first).count).to eq 0
				expect(IssueFile.where(data_files: DataFile.first).count).to eq 4
				expect(DataFile.first.status).to eq "failed"
			end
		end
	end
end