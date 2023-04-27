class Api::V1::PostsController < ApplicationController
  before_action :set_post, only: %i[ show update]
  before_action :set_ids, only: %i[ destroy post_likes post_comments ]

    skip_before_action :authenticate_user!
    skip_before_action :verify_authenticity_token

    def index
        posts=Post.all 
        render json: posts
    end

    def show
        if @post.present?
          render json:  @post
        else 
          render json: { error: "Record not found" }, status:404
        end
      end

    def create
        post=Post.new(post_params)
        if post.save
          render json: post, status: :created
  
        else 
          render json: { error: post.errors.full_messages }, status: :unprocessable_entity
        end
    end


    def destroy
        if @post.present?
            @post.destroy
            render json: { message:"Post has been Deleted"},status: :ok
        else
          render json: { error: "Post not exist" }, status:404
        end
    end


    def edit
        post=Post.find(params[:id])
    end
      
      def update
        if @post.present?
          @post.update(post_params)
          render json: @post, status: :ok
        else 
          render json: { error: "Record not found" }, status: :unprocessable_entity
        end
      end


    def post_title
      posts=Post.where(title:"Title4")
      render json: posts
    end


    def post_likes
    if @post.present?
        likes_count = @post.likes.count
        render json: { no_of_likes_on_posts: likes_count } 
      else 
        render json: { error: "Post is not found" }, status:404
      end
    end

    def post_comments
     if @post.present?
      count1 = @post.comments.count
      render json: { no_of_comments_on_posts: count1 }
    else 
      render json: { error: "post is not found" }, status:404
    end
    end
      
    private
    def set_ids
      @post = Post.find_by(id: params[:id])
    end 

    def set_post
      @post = Post.where(id: params[:id])
    end

    def post_params
        params.require(:post).permit(:title, :description, :keyword, :user_id)

    end

end
