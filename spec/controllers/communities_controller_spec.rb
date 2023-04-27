require 'rails_helper'

RSpec.describe CommunitiesController do
        let(:user){create:user}
        let(:community1){create :community}
       
describe 'GET index' do
       
      
        before(:each) do
            sign_in(user)
         get :index
        end

            it 'returns a successful response' do   
                expect(response).to be_successful
            end
            

            it 'assigns @communities' do
                expect(assigns(:communities)).to eq([community1])
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
        it "creates a new community " do
        post :create, params: { community: { name: "community1"},}
        expect(Community.exists?(community1.id)).to be true

        end
    end

    context "with invalid params" do
        it "does not create a new account" do
        expect {
            post :create, params: { community: { name: ""} }
        }.not_to change(Community, :count)
        end
    end
end


describe "DELETE #destroy" do
before(:each) do
    sign_in(user)
 end 
  it "destroys the community" do
      delete :destroy, params: { id: community1.id, community: { name: "community1" }}
    expect(Community.exists?(community1.id)).to be false
  end
end
  
 
end
