module Callfxkudi
    def generateReference
        dt = Date.now 
        sprintf("%s%06d", dt.strftime("%y%m%d"), rand(1..999999))
    end 

    require 'net/http'
    require 'uri'
    require 'json'
    def newCard(user_id)
        @user = User.find(user_id)
        if @user.nil?
            return 0
        end


        data = {
            "merchantid" => "22",
            "publickey" => "FXKPUB512381764487",
            "cardholder" => @user.name,
            "customer_email"  =>  @user.email,
            "customer_name"  =>  @user.name,
            "customer_phone"  =>  @user.phone,
            "reference"  =>  generateReference
          }
          
    
        uri = URI.parse("https://www.fxkudi.com/merchant/api/card-generation")
        request = Net::HTTP::Post.new(uri)
        request.content_type = "application/json"
        request.body = data.to_json

        req_options = {
            use_ssl: uri.scheme == "https",
        }
        
        response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
            http.request(request)
        end

        response.body
    end



    def funding(card_id, amount)
        @carte = Carte.find_by(card_id: card_id)
        if @carte.nil?
            return 0
        end

        @user = User.find(@carte.user_id)

        data = {
            "merchantid" => "22",
            "publickey" => "FXKPUB512381764487",
            "cardid" => card_id,
            "amount" => amount,          
            "customer_email" => @user.email,
            "customer_name" => @user.name,
            "customer_phone" => @user.phone,
            "reference" => generateReference
          }
          
    
        uri = URI.parse("https://www.fxkudi.com/merchant/api/card-funding")
        request = Net::HTTP::Post.new(uri)
        request.content_type = "application/json"
        request.body = data.to_json

        req_options = {
            use_ssl: uri.scheme == "https",
        }
        
        response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
            http.request(request)
        end

        response.body
    end

    def card_details(card_id)
        @carte = Carte.find_by(card_id: card_id)
        if @carte.nil?
            return 0
        end

        @user = User.find(@carte.user_id)

        data = {
            "merchantid" => "22",
            "publickey" => "FXKPUB512381764487",
            "cardid" => card_id
          }
          
    
        uri = URI.parse("https://www.fxkudi.com/merchant/api/get-card")
        request = Net::HTTP::Post.new(uri)
        request.content_type = "application/json"
        request.body = data.to_json

        req_options = {
            use_ssl: uri.scheme == "https",
        }
        
        response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
            http.request(request)
        end

        response.body
    end

end

