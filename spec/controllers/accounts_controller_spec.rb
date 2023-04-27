require 'rails_helper'

RSpec.describe AccountsController do
    let!(:user){create :user}
        let(:account1){create :account,user:user}
       
describe 'GET index' do
       
   
        before(:each) do
            sign_in(user)
         get :index
        end

            it 'returns a successful response' do   
                expect(response).to be_successful
            end
            
            it 'render the index template' do
                expect(response).to render_template('index')
            end
        
end 

describe 'POST #create' do 
    before(:each) do
        sign_in(user)
    end
 
 
    context "when user is signed in" do
        it "creates a new account" do
        post :create, params: { account: { name: "Sonu Kumar", address: "address1",phone:"1234567890"} ,user_id:user.id}
        expect(Account.exists?(account1.id)).to be true

        end
    end

    context "with invalid params" do
        it "does not create a new account" do
        expect {
            post :create, params: { account: { name: "", address: "" }, user_id: user.id }
        }.not_to change(Account, :count)
        end
    end
end



describe "PUT #update" do
 before(:each) do
    sign_in(user)
 end 

  context "with valid params" do
    it "updates the account" do
      put :update, params: { id: account1.id, account: { name: "name1" }, user_id: user.id }
      account1.reload
      expect(account1.name).to eq "name1"
    end
  end

context "with invalid params" do
    it "does not update the account" do
      put :update, params: { id: account1.id, account: { name: "" }, user_id: user.id }
      account1.reload
      expect(account1.name).not_to eq ""
    end
  end
end
 
end
