class GroupsController < ApplicationController

def index
 @groups=Group.all
end

def new
 @group=Group.new
end

def show
    @group = Group.find(params[:id])
    @users= @group.users
   
end



def create
    @group=Group.new(group_params) 
    if @group.save
        redirect_to @group
    else
        render 'new'
    end
end

def destroy
    @group = Group.find(params[:id])
    @group.destroy

    redirect_to groups_path, notice: "Group was successfully deleted."
  end

private
    def group_params
        params.require(:group).permit(:name,:community_id)
    end

end
