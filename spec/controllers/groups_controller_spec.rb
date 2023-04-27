require 'rails_helper'

RSpec.describe GroupsController do

        let(:user){create:user}
        let(:community1){create :community}
        let(:group1){ create:group, community:community1}
        
       
describe 'GET index' do
       
      
        before(:each) do
            sign_in(user)
         get :index
        end

            it 'returns a successful response' do   
                expect(response).to be_successful
            end
            

            it 'assigns @groups' do
                expect(assigns(:groups)).to eq([group1])
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
        it "creates a new group " do
        post :create, params: { group: { name: "group1"},community_id:community1.id}
        expect(Group.exists?(group1.id)).to be true

        end
    end

    context "with invalid params" do
        it "does not create a new group" do
        expect {
            post :create, params: { group: { name: ""},community_id:community1.id}
        }.not_to change(Group, :count)
        end
    end
end


describe "DELETE #destroy" do
before(:each) do
    sign_in(user)
 end 
  it "destroys the group" do
      delete :destroy, params: { id: group1.id, group: { name: "community1" },community_id:community1.id}
    expect(Group.exists?(group1.id)).to be false
  end
end
  
 
end
