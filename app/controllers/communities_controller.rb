class CommunitiesController < ApplicationController

def index
    @communities=Community.all
end

def new 
 @community=Community.new
end

def show
    @community = Community.find(params[:id])
    @groups = @community.groups
end

def create
    @community=Community.new(community_params)
    if @community.save
        redirect_to communities_path
    else
        render 'new'
    end  
end


def destroy
    @community = Community.find(params[:id])
    @community.destroy

    redirect_to communities_path, notice: "Community was successfully deleted."
  end



private
 def community_params
    params.require(:community).permit(:name)
 end
end
