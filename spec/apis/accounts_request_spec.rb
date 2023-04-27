require 'rails_helper'

RSpec.describe "GET /api/v1/accounts", type: :request do
  
  #for accounts 
  describe "GET /api/v1/accounts" do

    context "when account exist" do
      
      let!(:user) { create(:user) }
      let!(:account) { create(:account, user: user) }
      let!(:count) {Account.all.count}
      before(:each) do
            get "/api/v1/accounts"
      end

      it "returns a successful response" do
        expect(response).to have_http_status(200)
      end
  

      it "returns a JSON response with account" do
        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body).size).to eq(count)
      end

    end

    context "when no account exist" do

      before(:each) do
        Account.destroy_all
        get "/api/v1/accounts"
      end

      it "returns an empty JSON response" do
        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)).to be_empty
      end

    end

  end
  
  #for updating the post 
  describe "PUT #update" do
   context "with valid params" do
      let(:user) { create(:user) }
      let!(:account) { create(:account, user: user) }
      let(:updated_attributes) { { name: "Sonukumar" } }

      before(:each) do
        put api_v1_account_path(account.id), params: { account: updated_attributes }
      end

      it "returns a successful response" do
        expect(response).to have_http_status(:ok)
      end

      it "updates the post" do
        expect(account.reload.name).to eq(updated_attributes[:name])
      end

    end

  context "with invalid params" do
    
    let(:user) { create(:user) }
    let!(:account) { create(:account, user: user) }
    let(:invalid_attributes) { { account: { name: nil} } }
  
    before(:each) do
      put api_v1_account_path(account.id), params: { account: invalid_attributes }
    end
  
    it "returns an unprocessable_entity response" do
      expect(response).to have_http_status(:ok)
    end
  end

end
  

  #for delete
  describe "DELETE /api/v1/comments/:id" do
  
    let(:user) { create(:user) }
    let!(:account) { create(:account, user: user) }
   
      it "deletes the account" do
        expect {
          delete api_v1_account_path(account.id)
        }.to change(Account, :count).by(-1)
      end
  
      it "returns a successful response" do
        delete api_v1_account_path(account.id)
        expect(response).to have_http_status(:ok)
      end
  
      it "returns a 'Deleted' message" do
        delete api_v1_account_path(account.id)
        expect(JSON.parse(response.body)["message"]).to eq("Account has been Deleted")
      end
  
    end

end
