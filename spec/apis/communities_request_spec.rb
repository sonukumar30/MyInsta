require 'rails_helper'

RSpec.describe "GET /api/v1/communities", type: :request do
   
  
  #for all posts 
  describe "GET /api/v1/communities" do

   
    let(:community1){create :community}

    context "when communities exist" do
    
      before(:each) do
        get "/api/v1/communities"
      end

      it "returns a successful response" do
        expect(response).to have_http_status(200)
      end
    end
  end

  #for creating a community through api 
  describe "POST create" do

    context "with valid attributes" do

      
      let(:community1){create :community}
      let(:valid_attributes) {{ community: { name: "sonukumar"} }}
  
      before(:each) do
          post "/api/v1/communities", params: valid_attributes
      end

      it "returns a successful response" do
        expect(response).to have_http_status(:created)
      end

      it "creates a new community" do
        expect {
          post "/api/v1/communities", params: valid_attributes
        }.to change(Community, :count).by(1)
      end

      it "returns the created community in the response" do
        expect(JSON.parse(response.body)["name"]).to eq("sonukumar")
      end

    end

    context "with invalid attributes" do
      let(:community1){create :community}
      let(:invalid_attributes) {{ community: { name: ""} }}
  
      before(:each) do
          post "/api/v1/communities", params: invalid_attributes
      end

      it "returns a successful response" do
        expect(response).to have_http_status(422)
      end

      it "creates a new community" do
        expect {
          post "/api/v1/communities", params: invalid_attributes
        }.not_to change(Community, :count)
      end

      it "returns the created community in the response" do
        expect(JSON.parse(response.body)["error"]).to_not be_empty
      end

    end
  end


  # for destroy action 
 describe "DELETE /api/v1/communities/:id" do
  
    let(:community){create :community}
    
    it "returns a successful response" do
      delete api_v1_community_path(community.id)
      expect(response).to have_http_status(:ok)
    end

    it "returns a 'Deleted' message" do
      delete api_v1_community_path(community.id)
      expect(JSON.parse(response.body)["message"]).to eq("Community has been Deleted")
    end

  end

  

end
