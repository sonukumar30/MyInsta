require 'rails_helper'

RSpec.describe "GET /api/v1/posts", type: :request do
  
  #for all posts 
  describe "GET /api/v1/posts" do

    context "when posts exist" do
      let!(:count) {Post.all.count}
      let!(:user) { create(:user) }
      let!(:posts) { create_list(:post, 3, user: user) }

      before(:each) do
        get "/api/v1/posts"
      end

      it "returns a successful response" do
        expect(response).to have_http_status(200)
      end
  

      it "returns a JSON response with all posts" do
        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body).size).to eq(count+3)
      end

    end

    context "when no posts exist" do

      before(:each) do
        Post.destroy_all
        get "/api/v1/posts"
      end

      it "returns an empty JSON response" do
        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)).to be_empty
      end

    end

  end


  #for show post with id 
  describe "GET /api/v1/posts/:id" do
    context "when the post exists" do
      let!(:user) { create(:user) }
     
      let!(:post) { create(:post, user: user) }
      
      before { get "/api/v1/posts/#{post.id}" }
      
      it "returns a success response" do
        expect(response).to have_http_status(:success)
      end
      
      it "return the post in JSON format" do
        response.body == post.to_json
      end
    end
    
    context "when the post does not exist" do
      before { get "/api/v1/posts/999" }
      
      it "returns a 404 not found status" do
        expect(response).to have_http_status(:not_found)
      end
      
      it "returns an error message in JSON format" do
        expect(response.body).to eq({ message: "Record not found" }.to_json)
      end
    end
  end

  #for creating a post through api 
  describe "POST create" do
    context "with valid attributes" do
      let(:user) { create(:user) }
      
      let(:valid_attributes) { { post: { title: "title1", description: "Test Description",keyword: "keyword" ,user_id: user.id } } }
  
      it "creates a new post" do
        expect {
          post "/api/v1/posts", params: valid_attributes
        }.to change(Post, :count).by(1)
      end
  
      it "returns a successful response" do
        post "/api/v1/posts", params: valid_attributes
        expect(response).to have_http_status(:created)
      end
  
      it "returns the created post in the response" do
        post "/api/v1/posts", params: valid_attributes
        expect(JSON.parse(response.body)["title"]).to eq("title1")
        expect(JSON.parse(response.body)["description"]).to eq("Test Description")
        expect(JSON.parse(response.body)["keyword"]).to eq("keyword")
      end
    end
  
    context "with invalid attributes" do
      let(:user) { create(:user) }
      let(:invalid_attributes) { { post: { title:'', description:"ndnffdhj",keyword:"keyword",user_id: user.id} } }
  
      it "does not create a new post" do
        expect {
          post "/api/v1/posts", params: invalid_attributes
        }.to_not change(Post, :count)
      end
  
      it "returns an error post in the response" do
        post "/api/v1/posts", params: invalid_attributes
        expect(JSON.parse(response.body)["error"]).to_not be_empty
      end
  
      it "returns a 422 unprocessable entity status code" do
        post "/api/v1/posts", params: invalid_attributes
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end


  #for updating the post 
  describe "PUT #update" do
   context "with valid params" do
      let(:user) { create(:user) }
    
      let!(:post) { create(:post, user: user) }
      let(:updated_attributes) { { title: "New Title" } }

      before(:each) do
        put api_v1_post_path(post.id), params: { post: updated_attributes }
      end

      it "returns a successful response" do
        expect(response).to have_http_status(:ok)
      end

      it "updates the post" do
        expect(post.reload.title).to eq(updated_attributes[:title])
      end

    end
  context "with invalid params" do
    let(:user) { create(:user) }
   
  
    let!(:post) { create(:post, user: user) }
  
    let(:invalid_attributes) { { post: { title: nil, description: nil } } }
  
    before(:each) do
      put api_v1_post_path(post.id), params: { post: invalid_attributes }
    end
  
    it "returns an unprocessable_entity response" do
      expect(response).to have_http_status(:ok)
    end
  
    it "does not update the post" do
      expect(post.reload.description).to_not eq(invalid_attributes[:post][:description])
    end
  end
  
  context "when the post does not exist" do
    before(:each) do
      put api_v1_post_path(0), params: { post: { title: "New Title" } }
    end

    it "returns a 404 response" do
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "returns an error message" do
      expect(JSON.parse(response.body)["message"]).to eq("Record not found")
    end
  end

end

 # for destroy action 
 describe "DELETE /api/v1/posts/:id" do
  
  let(:user) { create(:user) }
  let!(:post) { create(:post, user: user) }
   
    it "deletes the post" do
      expect {
        delete api_v1_post_path(post.id)
      }.to change(Post, :count).by(-1)
    end

    it "returns a successful response" do
      delete api_v1_post_path(post.id)
      expect(response).to have_http_status(:ok)
    end

    it "returns a 'Deleted' message" do
      delete api_v1_post_path(post.id)
      expect(JSON.parse(response.body)["message"]).to eq("Post has been Deleted")
    end

  end
  
  #custom api post_likes 
  describe '#post_likes' do
  let(:user) { create(:user) }
  let(:post) { create(:post, user: user ) }
  
  context 'when post exists' do
    before { 
      get "/api/v1/posts/post_likes", params: { id: post.id } 
      
    }
    
    it 'returns the number of likes on the post' do
      expect(JSON.parse(response.body)) == post.likes.count
    end
  
  end 

  context 'when post does not exist' do
    before do
      get "/api/v1/posts/post_likes"
    end
    
    it 'returns a 404 error' do
      expect(response).to have_http_status(404)
    end
  end
 end

 #custom api post_comments 
 describe '#post_comments' do
 let(:user) { create(:user) }
 let(:post) { create(:post, user: user ) }
 
  context 'when post exists' do
    before { 
      get "/api/v1/posts/post_comments", params: { id: post.id } 
      
    }
    
    it 'returns the number of comments on the post' do
      expect(JSON.parse(response.body)) == post.comments.count
    end
  end 

  context 'when post does not exist' do
    before do
      get "/api/v1/posts/post_comments"
    end
    
    it 'returns a 404 error' do
      expect(response).to have_http_status(404)
    end
  end





end



end