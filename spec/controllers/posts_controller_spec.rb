require 'rails_helper'

RSpec.describe PostsController do
    let!(:user){create :user}
        let(:post1){create :post,user:user}
        let(:post2) { create:post, user: user}

describe 'GET index' do
       
      
        before(:each) do
         get :index
        end

            it 'returns a successful response' do   
                expect(response).to be_successful
            end
            

            it 'assigns @posts' do
                expect(assigns(:posts)).to eq([post1])
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
        it "creates a new post" do
        post :create, params: { post: { title: "Test Post", description: "This is a test post.",keywords:"ajsdhgcjhgv"} ,user_id:user.id}
        expect(Post.exists?(post1.id)).to be true

        end
    end

    context "with invalid params" do
        it "does not create a new post" do
        expect {
            post :create, params: { post: { title: "", description: "" }, user_id: user.id }
        }.not_to change(Post, :count)
        end
    end
end



describe "PUT #update" do
before(:each) do
    sign_in(user)
 end 
  context "with valid params" do
    it "updates the post" do
      put :update, params: { id: post1.id, post: { title: "Updated Title" }, user_id: user.id }
      post1.reload
      expect(post1.title).to eq "Updated Title"
    end
  end

context "with invalid params" do
    it "does not update the post" do
      put :update, params: { id: post1.id, post: { title: "" }, user_id: user.id }
      post1.reload
      expect(post1.title).not_to eq ""
    end
  end
end

describe "DELETE #destroy" do
before(:each) do
    sign_in(user)
 end 
  it "destroys the post" do
      delete :destroy, params: { id: post1.id, post: { title: "Test Post", description: "This is a test post." ,keywords:"ajsdhgcjhgv" },user_id: user.id }
    expect(Post.exists?(post1.id)).to be false
  end
end
  

  
end
