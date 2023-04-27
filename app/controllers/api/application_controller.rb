module Api
    class ApplicationController < ActionController::API
      # equivalent of authenticate_user! on devise, but this one will check the oauth token
      before_action :doorkeeper_authorize!
  
      private
  
      # helper method to access the current user from the token
      def create
        user = User.find_by(email: params[:email])
        if user&.authenticate(params[:password])
          token_request = Doorkeeper::OAuth::PasswordAccessTokenRequest.new(
            Doorkeeper.configuration,
            Doorkeeper::OAuth::Client.find_by(uid: params[:client_id]),
            user,
            { scope: params[:scope] }
          )
          token = token_request.authorize
          render json: { access_token: token.token, token_type: 'bearer' }
        else
          render json: { error: 'Invalid email or password' }, status: :unauthorized
        end
      end






    end
  end