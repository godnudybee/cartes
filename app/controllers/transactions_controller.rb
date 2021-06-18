class TransactionsController < ApplicationController
    def detail_transactions
        carte_id = params["carte_id"]
        debut = params.member? "debut" ? params["debut"] : nil
        fin = params.member? "fin" ? params["fin"] : nil

        tout = Transaction.where("carte_id" : carte_id)
        if debut.nil?
            tout = Transaction.where(["dateCreated >= ?", debut])
        end
        if fin.nil?
            tout = Transaction.where(["dateCreated >= ?", fin])
        end

        render json: tout.to_json
    end
end
