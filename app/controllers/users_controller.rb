class UsersController < ApplicationController
    require 'Savingimages'
    
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
            @user.name = params["name"]
            @user.email = params["email"]
            @user.name = params["name"]
        else
            render json: {"status": 0, "message": "Le compte existe déja"}
            return
        end
        #######################################################
        puts params
        @user_exists = Savingimages.find_by(phone: params[:phone])
      
        @user.document_url = Savingimages.create_file_from_upload_data(
          params[:document_url], 
          Savingimages.user_img_dir
        )
        @user.photo_url = Savingimages.create_file_from_upload_data(
          params[:photo_url], 
          Savingimages.user_img_dir
        )

        #######################################################
        if @user.save
            render json: {"status": 1, "id": @user.id}
            return
        end

        render json: {"status": 0, "message": "le compte n'a pas pu être créé"}
    end
end
