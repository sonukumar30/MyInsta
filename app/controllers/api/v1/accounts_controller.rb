class Api::V1::AccountsController < ApplicationController
    skip_before_action :authenticate_user! 
    skip_before_action :verify_authenticity_token

    def index
        accounts=Account.all
        render json: accounts
    end

    
  def new
    account=Account.new
  end

  def create
    account=Account.new(account_params)    
  
    if account.save
        render json: account, status: :created
    else
        render json: { error: account.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    account=Account.where(id: params[:id])
    if account.present?
        render json: account
    else 
       render json: { error: "Account not exist "}, status:404
    end
  end

  def destroy
    account=Account.find_by(id:params[:id])
    if account
        account.destroy
        render json: { message: "Account has been Deleted"},status: :ok
    end
  end

  
  def edit
    account=Account.find(params[:id])
  end
  
  def update
    account= Account.where(id: params[:id])
    if account.present?
     account.update(account_params)
     render json: account, status: :ok
    else
        render json: { error: "Record not found" },status:404 
    end
  end
  
  
  
  private
  def account_params
    params.require(:account).permit(:name,:address,:phone,:user_id)
  end
    
end
