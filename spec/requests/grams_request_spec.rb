# frozen_string_literal: true

require 'rails_helper'
RSpec.describe GramsController, type: :request do

  describe "grams#edit action" do
    it "should successfully show the edit form if the gram is found" do
      gram = FactoryBot.create(:gram)
      get edit_gram_path(gram.id)
      expect(response).to have_http_status(:success)
    end

    it "should return a 404 error message if the gram is not found" do
      get edit_gram_path('TACOCAT')
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "grams#show action" do

    it "should successfully show the page if the gram is found" do
      gram = FactoryBot.create(:gram)
      get gram_path(gram.id)
      expect(response).to have_http_status(:success)
    end

    it "should return a 404 error if the gram is not found" do
      get gram_path('TACOCAT')
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'grams#index action' do
    it 'should successfully show the page' do
      get root_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'grams#new action' do
    it "should require users to be logged in" do
      get new_gram_path
      expect(response).to redirect_to new_user_session_path
    end

    it 'should successfully show the new form' do
      user = FactoryBot.create(:user)
      sign_in user

      get new_gram_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'grams#create action' do
    it "should require users to be logged in" do
      post grams_path, params: { gram: { message: 'Hello!' } }
      expect(response).to redirect_to new_user_session_path
    end

    it 'should successfully create a new gram in our database' do
      user = FactoryBot.create(:user)
      sign_in user

      post grams_path, params: { gram: { message: 'Hello!' } }
      expect(response).to redirect_to root_path

      gram = Gram.last
      expect(gram.message).to eq('Hello!')
      expect(gram.user).to eq(user)
    end

    it 'should properly deal with validation errors' do
      user = FactoryBot.create(:user)
      sign_in user

      gram_count = Gram.count
      post grams_path, params: { gram: { message: '' } }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(gram_count).to eq Gram.count
    end
  end
end
