class TController < ApplicationController
    def init_data
        Typepaiement.create(:libelle : "newcard")
        Typepaiement.create(:libelle : "depot")


        Infotype.create(:json : "{\"prix_fcfa\":{\"valeur\": 2000, \"description\": \"le prix de la carte virtuelle en fcfa\"}, \"cout_carte\":{\"valeur\": 2000, \"description\": \"le coût de la carte virtuelle en usd chez FxKudi\"}, \"depot_intial\":{\"valeur\": 1, \"description\": \"le montant initial sur la carte\"} }")
        Infotype.create(:json : "{\"tx_pg\":{\"valeur\": \"0.04\", \"description\": \"Taux PaygateGlobal prélevé sur chaque montant en fcfa payé\"}, \"tx_fx\":{\"valeur\": \"0.005\", \"description\": \"Taux FxKudi prélevé sur chaque montant en dollar payé\"}, \"tx_ec\":{\"valeur\": \"0.005\", \"description\": \"Taux E-Carte prélevé sur chaque montant en dollar payé\"} }")
 
    end
end
