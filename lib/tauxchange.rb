module Tauxchange
    def valeurTaux(montant)
        #taux
        #loaded_amount
        #remaining_amount
        @ldg = Loading.where(["created_at < ?", DateTime.now])
        .where(["remaining_amount > 0"])
        .order("created_at")

        if @ldg.nil?
            return 0
        end
#####################################################
        x = montant
        t = 0
        @ldg.each do |l|
            if l.remaining_amount < montant
                x -= l.remaining_amount
                l.remaining_amount = 0
                l.save
            else
                l.remaining_amount -= montant
                l.save 

                t = l.taux
            end
        end

        return t
    end

    def valeurTauxMajore(montant)
        type = Typepaiement.find(TYPE_DEPOT)
        infotype = Infotype.find(type.info_id)

        l_info_json = JSON.parse(infotype["json"]) 
        tx_pg = l_info_json["tx_pg"]["valeur"].to_i
        tx_fx = l_info_json["tx_fx"]["valeur"].to_i
        tx_ec = l_info_json["tx_ec"]["valeur"].to_i
        ############################################
        facteur = 1/((1 - tx_pg) * (1 - (tx_fx + tx_ec)))

        return valeurTaux(montant) * facteur
    end
end