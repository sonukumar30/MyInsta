class Api::V1::CommentsController < ApplicationController
    skip_before_action :authenticate_user!
    skip_before_action :verify_authenticity_token

    def index
        comments=Comment.all 
        render json: comments
    end

    def show
        comment=Comment.where(id: params[:id])
        if comment.present?
          render json: comment
        else 
          render json: { error: "Record not found" }, status:404
        end
      end

    def create
        comment=Comment.new(comment_params)
        if comment.save
          render json: comment, status: :created
  
        else 
          render json: { error: comment.errors.full_messages }, status: :unprocessable_entity
        end
    end


    def destroy
        comment=Comment.find_by(id:params[:id])
        if comment
            comment.destroy
            render json: { message:"Comment has been Deleted"},status: :ok
        end
    end


    def edit
        comment=Comment.find(params[:id])
    end
      
      def update
        comment= Comment.where(id: params[:id])
    
        if comment.present?
          
          comment.update(comment_params)
          render json: comment, status: :ok
        else 
          render json: { error: "Record not found" }, status:404
        end
      end
      
    private
    def comment_params
        params.require(:comment).permit(:body , :user_id, :post_id)

    end

end
