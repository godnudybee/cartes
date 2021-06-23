class CartesController < ApplicationController
    def detail_carte
        carte_id = params["carte_id"]
        @carte = Carte.find_by(carte_id)
        if @carte.nil?
            @carte = {}
        end
        render json: @carte.to_json
    end 

    def liste_par_user
        user_id = params["user_id"]
        @tout = Carte.where("user_id" => user_id)

        render json: @tout.to_json
    end
end
