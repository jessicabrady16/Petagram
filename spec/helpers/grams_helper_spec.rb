require 'rails_helper'

RSpec.describe GramsController, type: :request do
  describe "grams#index action" do
    it "should successfully show the page" do
      get root_path
      expect(response).to have_http_status(:success)
    end
  end
end
