class Api::V1::CommunitiesController < ApplicationController
   
      skip_before_action :authenticate_user!
      skip_before_action :verify_authenticity_token
  
      def index
          communities=Community.all 
          render json: communities
      end


      def create
        community=Community.new(community_params)
        if community.save
            render json: community, status: :created
        else
            render json: { error: community.errors.full_messages }, status: :unprocessable_entity
        end  
    end


    def destroy
        community = Community.find_by(params[:id])
        if community
            community.destroy
            render json: { message:"Community has been Deleted"},status: :ok
        else
          render json: { error: "Community not exist" }, status:404
        end
    end

    private
        def community_params
            params.require(:community).permit(:name)
        end
        
end  