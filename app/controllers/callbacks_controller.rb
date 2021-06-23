class CallbacksController < ApplicationController
    #{
    #    "tx_reference": 359670,
    #    "payment_reference": "2210618233547",
    #    "amount": 150,
    #    "datetime": "2021-06-18 18:45:19 UTC",
    #    "identifier": "14983",
    #    "payment_method": "FLOOZ",
    #    "phone_number": "22897019198"
    #  }

    require 'callfxkudi'
    def paygateglobal
        id = params["identifier"]
        dmd = Paiementpaygate.find(id)
        if dmd.nil?
            render json: 0
        end
        ##################################
        type = Typepaiement.find_by(info_id: dmd.info_type_pmt_id)
        infotype = InfoType.find(dmd.info_type_pmt_id)
        if infotype.nil? || type.nil?
            render json: 0
        end
        #---------------------------------
        dmd.tx_reference = params["tx_reference"]
        dmd.payment_reference = params["payment_reference"]
        dmd.date_paiement = params["datetime"]
        dmd.pmt_done = 1
        dmd.fxk_done = 0
        #---------------------------------
        if type.id == TYPE_NEWCARD
            newCard = Newcard.find_by(pmt_pg_id: id)
            if newCard.nil? || type.nil?
                render json: 0
            end
            state = newCard(@newCard.user_id)
                
            if state.member? "status" && state["status"] == "success" 
                carte = Carte.new
                carte.card_id = state["card_id"]
                carte.masked_pan = state["masked_pan"]
                carte.card_balance = state["card_balance"].gsub("USD", '').to_f
                carte.card_holder = state["card_holder"]
                carte.card_pan = state["card_pan"]
                carte.cardcurrency = state["card_currency"]
                carte.billing_name = state["billing_name"]
                carte.billing_address = state["billing_address"]
                carte.billing_city = state["billing_city"]
                carte.billing_country = state["billing_country"]
                carte.billing_zip_code = state["billing_zip_code"]
                
                state_details = card_details(state["card_id"])
                if state.member? "status" && state["status"] == "success"
                    carte.cardbalance = state["cardbalance"].to_f
                    carte.billing_state = state["billing_state"]
                    carte.card_currency = state["card_currency"]
                    carte.status = state["status"]
                    carte.zip_code = state["zip_code"]
                    carte.cvv = state["cvv"]
                    carte.expiration = state["expiration"]
                    carte.active = state["active"] == "true" ? 1 : 0
                    ###################################################""
                    dmd.fxk_done = 1
                end
                carte.save
            end

        elsif type.id == TYPE_DEPOT 
            depot = Depot.find_by(pmt_pg_id: id)
            if depot.nil? || type.nil?
                render json:0
            end
            state = funding(depot.card_id, depot.montant)
                
            if state.member? "status" && state["status"] == "success" 
                carte = Carte.find_by(card_id: depot.card_id)
                state_details = card_details(state["card_id"])
                if state.member? "status" && state["status"] == "success"
                    carte.card_balance = state["cardbalance"].to_f
                    carte.cardbalance = state["cardbalance"].to_f
                    carte.card_currency = state["card_currency"]
                    carte.active = state["active"] == "true" ? 1 : 0
                    ###################################################""
                    dmd.fxk_done = 1
                end
                carte.save
            end
        end

        dmd.save
    end
end
