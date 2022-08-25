class ExpiryController < ApplicationController
    def add
        user = User.find_by!(email: params[:email])
        @exp_token = ExpiryToken.create!(token_params)
        if @exp_token.save
            render json: [message: "You are logged out"]
        else
            render json: { errors: user.errors.full_messages }, status: :bad_request
        end
    end

    private
    def token_params
        params.permit(
            :exp_token
        )
    end
end