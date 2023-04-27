class MembershipsController < ApplicationController

        def index
         @memberships=Membership.all
         
         
        end
        
        def new
         @membership=Membership.new
        end
        
        def show
            @membership = Membership.find(params[:id])
            @users = @membership.user
           
        end
    
        
        def create
            @membership = Membership.new(membership_params)
          
            if Membership.exists?(group_id: @membership.group_id, user_id: @membership.user_id)
              flash[:error] = "You have already joined."
              redirect_to memberships_path
            elsif @membership.save
              redirect_to @membership, notice: 'Welcome,You joined the group.'
            else
              render :new
            end
          end
          
        
        
        private
            def membership_params
                params.require(:membership).permit(:name,:user_id,:group_id)
            end
        
        
        
end
