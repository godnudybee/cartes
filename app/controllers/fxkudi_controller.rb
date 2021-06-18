TYPE_NEWCARD = 1
TYPE_DEPOT = 2

class FxkudiController < ApplicationController
    def block_card
        #{"status":"success",
        #"message":"Card blocked successfully",
        #"cardid":"80322f29-9752-4339-8056-5cd90a6943b6"}
        @carte = Carte.find_by("card_id" : params["card_id"])
        if !@carte.nil?
            @carte.active = 0
            if Carte.save
                render json: {"status" : 1}
                return
            end
            render json: {"status": 0, "message": "Le blocage de la carte n'a pas été enregistré"}
            return
        end
        render json: {"status": 0, "message": "La carte n'a pas été trouvé"}
    end

    
    def unblock_card
        #{"status":"success",
        #"message":"Card blocked successfully",
        #"cardid":"80322f29-9752-4339-8056-5cd90a6943b6"}
        @carte = Carte.find_by("card_id" : params["card_id"])
        if !@carte.nil?
            @carte.active = 1
            if Carte.save
                render json: {"status" : 1}
                return
            end
            render json: {"status": 0, "message": "Le déblocage de la carte n'a pas été enregistré"}
            return
        end
        render json: {"status": 0, "message": "La carte n'a pas été trouvée"}
    end

    def generate_card
        #{
        #    "user_id": "1",
        #    "phone" : "22896644879",
        #    "cardholder": "BONIN Koffivi Nutepe"
        #}

        type = Typepaiement.find(TYPE_NEWCARD)

        @pmt = Paiementpaygate.new()
        @pmt.phone = params["phone"]
        @pmt.info_type_pmt_id = type.info_id
        #récupérer les infos sur les taux appliqués dans le json du Type DEPOT
        type = Typepaiement.find(TYPE_DEPOT)
        @pmt.type_id = type.id
        l_info_json = JSON.parse(type.json) 
        @pmt.tx_pg = l_info_json.["tx_pg"].valeur.to_i
        @pmt.tx_fx = l_info_json.["tx_fx"].valeur.to_i
        @pmt.tx_ec = l_info_json.["tx_ec"].valeur.to_i
        @pmt.pmt_done = 0
        @pmt.fxk_done = 0
        
        @pmt.save()
        ####
        #ajouter le "newCard"
        t.integer :pmt_pg_id
        t.string :cardholder
        t.integer :user_id
        @nc = Newcard.new()
        @nc.pmt_pg_id = @pmt.id 
        @nc.cardholder = params["cardholder"]
        @nc.user_id = params["user_id"]
        @nc.save()

        #lancer la demande de paiement PaygateGlobal
        


    end
    
    def fund_card

    end

    def write_transactions

    end
end
