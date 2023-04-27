class AccountsController < ApplicationController
  before_action :authenticate_user!
  def index
    @accounts=Account.all
    if current_user.account.present?
      @account=current_user.account
    else
      @account=nil
    end
  end


  def new
    @account=Account.new
  end

  def create
    @account=Account.new(account_params)    
  
    if @account.save
        redirect_to accounts_path ,notice: 'account has been created'
    else
        render :new
    end
  end
  
  def edit
    @account=Account.find(params[:id])
  end
  
  def update
    @account= Account.find(params[:id])
    @account.update(account_params)
    redirect_to accounts_path
  end
  
  
  
  private
  def account_params
    params.require(:account).permit(:name,:address,:phone,:user_id)
  end
end