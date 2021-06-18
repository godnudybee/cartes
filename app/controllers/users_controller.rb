class UsersController < ApplicationController

    def verify_credentials
        #{
        #    "phone": "22891367306",
        #    "password_digest": "togovabien"
        #}

        @user = User.find_by(phone: params["phone"])
        if @user.nil?
            good = 0
        else 
            good = @user.password_digest == params["password_digest"] ? @user.id : 0            
        end

        render json: good
    end

    def create
        @user = User.find_by("phone": params["phone"])

        if @user.nil?
            @user = User.new("phone": params["phone"], "password_digest": params["password_digest"])
        else
            render json: {"status": 0, "message": "Le compte existe déja"}
            return
        end

        if @user.save
            render json: {"status": 1, "id": @user.id}
            return
        end

        render json: {"status": 0, "message": "le compte n'a pas pu être créé"}
    end
end
