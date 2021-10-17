require 'rails_helper'

RSpec.describe "Contacts", type: :request do
  describe "GET /index" do
    before(:each) do
			@user = User.create(
				email: 'test@example.com', 
				password: 'password123',
				password_confirmation: 'password123'
			)
      sign_in @user
    end
    it "returns http success" do
      get "/contact"
      expect(response).to have_http_status(:success)
    end
  end

end
