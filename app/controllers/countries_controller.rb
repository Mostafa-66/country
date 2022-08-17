class CountriesController < ApplicationController
    def index
        json_response(message:"Hello, Countries")
    end
end
