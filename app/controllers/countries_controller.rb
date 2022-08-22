class CountriesController < ApplicationController
    def index
        user = User.find_by!(email: params[:email])
        if user && user.activated?
            json_response(message:"Hello, Countries")
        else
            json_response(message:"Please activate your account")
        end
    end

    def show
        user = User.find_by!(email: params[:email])
        if user && user.activated? && user.completed?
            render json: [message: "THis is show countries"]
        else
            render json: [message: "Email is either not activated or completed"]
        end
    end
end
