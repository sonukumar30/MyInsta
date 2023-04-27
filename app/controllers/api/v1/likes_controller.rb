class Api::V1::LikesController < ApplicationController
    skip_before_action :authenticate_user!
    skip_before_action :verify_authenticity_token

    def index
        likes=Like.all 
        render json: likes
    end

    def show
        like=Like.where(id: params[:id])
        if like.present?
          render json: like
        else 
          render json: { error: "Record not found" }, status:404
        end
      end

      def new
        like=Like.new
      end

      def create
        like=Like.new(like_params)
        if like.save
            render json: like, status: :created
        else
           render json: { error: like.errors.full_messages }, status: :unprocessable_entity
      end
     end

    def post_likes
        likes=Like.where(likeable_type:"Post")
        render json: likes
    end

    def comment_likes
        likes=Like.where(likeable_type:"Comment")
        render json: likes
    end

    def destroy
        like=Like.find( params[:id] )
        likeable=like.likeable
        like.destroy
        render json: "like has been Deleted"
    end



      private
      def like_params
         params.require(:like).permit(:likeable_id, :likeable_type, :user_id)
      end 

end
