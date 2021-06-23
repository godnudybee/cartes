module Paygateglobal
    
    # reel
    #TOKEN = "35a0a4da-f13f-4d81-aa01-11029a6dfdcc"
    TOKEN = "7d1f75ee-c4a0-4981-bf14-64f7a49359a4"
    def self.demandePaiement(phone, amount, description, identifier)
        require 'net/http'
        require 'uri'
        require 'json'
    
    
        data = {
            auth_token: TOKEN,
            phone_number: phone,
            amount: amount,
            description: description,
            identifier: identifier
        }
    
        uri = URI.parse("https://paygateglobal.com/api/v1/pay")
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