require 'rails_helper'

RSpec.describe GramsController, type: :controller do
 
  RSpec.describe GramsController, type: :request do
    describe 'grams#index action' do
      it 'should successfully show the page' do
        get root_path
        expect(response).to have_http_status(:success)
      end
    end

    describe 'grams#new action' do
      it 'should successfully show the new form' do
        get new_gram_path
        expect(response).to have_http_status(:success)
      end
    end

    describe 'grams#create action' do
      it 'should successfully create a new gram in our database' do
        post grams_path, params: { gram: { message: 'Hello!' } }
        expect(response).to redirect_to root_path

        gram = Gram.last
        expect(gram.message).to eq('Hello!')
      end

      it 'should properly deal with validation errors' do
        post grams_path, params: { gram: { message: '' } }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(Gram.count).to eq 0
      end
    end
  end
end
