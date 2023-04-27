require 'rails_helper'

RSpec.describe "GET /api/v1/comments", type: :request do
  
  #for comments
  describe "GET /api/v1/comments" do

    context "when comment exist" do
      
      let!(:user) { create(:user) }
      let!(:post) { create(:post,user: user) }
      let!(:comment) { create(:comment,post:post,user: user) }
      let!(:count) {Comment.all.count}
      before(:each) do
            get "/api/v1/comments"
      end

      it "returns a successful response" do
        expect(response).to have_http_status(200)
      end
  

      it "returns a JSON response with account" do
        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body).size).to eq(count)
      end

    end

    context "when no comment exist" do

      before(:each) do
        Comment.destroy_all
        get "/api/v1/comments"
      end

      it "returns an empty JSON response" do
        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)).to be_empty
      end

    end

  end

  #for creating a comment through api 
  describe "POST create" do
    context "with valid attributes" do
        let!(:user) { create(:user) }
        let!(:post) { create(:post,user: user) }
        let!(:comment) { create(:comment,post:post,user: user) }

        before(:each) do
            get "/api/v1/comments"
      end

      it "returns a successful response" do
        expect(response).to have_http_status(200)
      end
    end
end

  #for delete
  describe "DELETE /api/v1/comments/:id" do
  
    let(:user) { create(:user) }
    let!(:post) { create(:post, user: user) }
    let!(:comment) { create(:comment,post:post, user: user) }
     
      it "deletes the comment" do
        expect {
          delete api_v1_comment_path(comment.id)
        }.to change(Comment, :count).by(-1)
      end
  
      it "returns a successful response" do
        delete api_v1_comment_path(comment.id)
        expect(response).to have_http_status(:ok)
      end
  
      it "returns a 'Deleted' message" do
        delete api_v1_comment_path(comment.id)
        expect(JSON.parse(response.body)["message"]).to eq("Comment has been Deleted")
      end
  
    end

end
