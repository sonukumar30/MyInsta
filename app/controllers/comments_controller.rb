class CommentsController < ApplicationController
    def create
        @post = Post.find(params[:post_id])
        @comment = @post.comments.create(params[:comment].permit( :body , :user_id))
        redirect_to post_path(@post)
    end

    def destroy 
        @post = Post.find(params[:post_id])
        @comment = @post.comments.find(params[:id])
        if @comment.user == current_user
            @comment.destroy
            redirect_to post_path(@post)
        else
            redirect_to post_path(@post), alert: "You are not authorized to delete this comment."
        end  
    end


end
