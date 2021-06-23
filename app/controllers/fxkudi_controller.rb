TYPE_NEWCARD = 1
TYPE_DEPOT = 2


require "paygateglobal"
require "tauxchange"
class FxkudiController < ApplicationController
    def block_card
        #{"status":"success",
        #"message":"Card blocked successfully",
        #"cardid":"80322f29-9752-4339-8056-5cd90a6943b6"}
        @carte = Carte.find_by("card_id" => params["card_id"])
        if !@carte.nil?
            @carte.active = 0
            if Carte.save
                render json: {"status" => 1}
                return
            end
            render json: {"status" => 0, "message" => "Le blocage de la carte n'a pas été enregistré"}
            return
        end
        render json: {"status" => 0, "message" => "La carte n'a pas été trouvé"}
    end

    
    def unblock_card
        #{"status":"success",
        #"message":"Card blocked successfully",
        #"cardid":"80322f29-9752-4339-8056-5cd90a6943b6"}
        @carte = Carte.find_by("card_id" => params["card_id"])
        if !@carte.nil?
            @carte.active = 1
            if Carte.save
                render json: {"status" => 1}
                return
            end
            render json: {"status" => 0, "message" => "Le déblocage de la carte n'a pas été enregistré"}
            return
        end
        render json: {"status" => 0, "message" => "La carte n'a pas été trouvée"}
    end

    def generate_card
        #{
        #    "user_id": "1",
        #    "phone" : "22896644879",
        #    "cardholder": "BONIN Koffivi Nutepe"
        #}
        ################################################
        type = Typepaiement.find(TYPE_NEWCARD)
        infotype = Infotype.find(type.info_id)
        l_info_json = JSON.parse(infotype["json"])
        puts l_info_json 
        amount_card = l_info_json["prix_fcfa"]["valeur"].to_i
        
        @pmt = Paiementpaygate.new()
        @pmt.phone = params["phone"]
        @pmt.info_type_pmt_id = type.info_id
        @pmt.type_id = type.id
        #récupérer les infos sur les taux appliqués dans le json du Type DEPOT
        type = Typepaiement.find(TYPE_DEPOT)
        infotype = Infotype.find(type.info_id)

        l_info_json = JSON.parse(infotype["json"]) 
        @pmt.tx_pg = l_info_json["tx_pg"]["valeur"].to_i
        @pmt.tx_fx = l_info_json["tx_fx"]["valeur"].to_i
        @pmt.tx_ec = l_info_json["tx_ec"]["valeur"].to_i
        @pmt.pmt_done = 0
        @pmt.fxk_done = 0
        
        @pmt.save()
        puts @pmt.id
        ####
        #ajouter le "newCard"
        @nc = Newcard.new()
        @nc.pmt_pg_id = @pmt.id
        @nc.cardholder = params["cardholder"]
        @nc.user_id = params["user_id"]
        @nc.save()

        #lancer la demande de paiement PaygateGlobal
        render json: Paygateglobal.demandePaiement(@pmt.phone, 
            amount_card, 
            "Nouvelle carte pour \"#{@nc.cardholder}\"", 
            @pmt.id - 2000)
        


    end
    
    def fund_card
        #{
        #    "amount" : 500000, 
        #    "phone" : "22896644879",
        #    "card_id": "BONIN Koffivi Nutepe"
        #}
        ################################################
        amount = params["amount"]
        #récupérer les infos sur les taux appliqués dans le json du Type DEPOT
        type = Typepaiement.find(TYPE_DEPOT)
        infotype = Infotype.find(type.info_id)

        l_info_json = JSON.parse(infotype["json"])         
        
        @pmt = Paiementpaygate.new()
        @pmt.phone = params["phone"]
        @pmt.info_type_pmt_id = type.info_id
        @pmt.type_id = type.id
        
        @pmt.tx_pg = l_info_json["tx_pg"]["valeur"].to_i
        @pmt.tx_fx = l_info_json["tx_fx"]["valeur"].to_i
        @pmt.tx_ec = l_info_json["tx_ec"]["valeur"].to_i

        @pmt.pmt_done = 0
        @pmt.fxk_done = 0
        
        @pmt.save()
        puts @pmt.id
        ####
        #ajouter le "Depot"
        @dp = Depot.new()
        @dp.pmt_pg_id = @pmt.id
        @dp.montant_usd = amount
        @dp.card_id= params["card_id"]        
        @dp.save()

        #lancer la demande de paiement PaygateGlobal
        render json: Paygateglobal.demandePaiement(@pmt.phone, 
            amount, 
            "Dépôt d'argent sur la carte <br/> #{params["card_id"]}", 
            @pmt.id - 2000)

    end

    def write_transactions

    end
end
