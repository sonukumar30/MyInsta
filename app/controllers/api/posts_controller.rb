module Api
    class PostsController < Api::ApplicationController
      before_action :set_ids, only: %i[ show destroy update ]

     
        def index
          posts=Post.all 
            render json: posts
        end
    
       
        def show
         if @post.present?
            if @flag.present?
              render json: @post
            else
              render json: { error: "you are not authorized seen the post" }, status:403 
            end
          else 
              render json: { error: "Record not found" }, status:404
          end
        end
    
        def create
          @user = User.find(doorkeeper_token.resource_owner_id)
          post= @user.posts.new(post_params)
            if post.save
              render json: post, status: :created
            else 
              render json: { error: post.errors.full_messages }, status: :unprocessable_entity
            end
        end
    
    
        def destroy
          if @post.present?
              if @flag.present?
                @post.destroy
                render json: "Post deleted successfully"
              else 
                render json: { error: "You are not authorized to delete the post" }, status:403
              end
            else
              render json: { error: "Post not found" }, status:404 
            end
        end
    
    
        def update
          if @post.present?
            if @flag.present?
             @post.update(post_params)
             render json: @post, status: :ok
            else 
               render json: { error: "You are not authorized to update the post" }, status:403
            end
          else 
            render json: { error: "Post not found" }, status:404
          end
        end
      
        
    
    
        def post_title
          posts=Post.where(title:"Title4")
          render json: posts
        end
          
        

        def post_params
            params.require(:post).permit(:title, :description, :keyword, :user_id)
  
        end


     private
     def set_ids
          @user = User.find(doorkeeper_token.resource_owner_id)
          @post= Post.find_by(id: params[:id])
          @flag= @user.posts.where(id: params[:id])
     end 


    
    end 
end