module PaygateGlobal
    TOKEN = "35a0a4da-f13f-4d81-aa01-11029a6dfdcc"
    def demandePaiement(phone, amount, description, identifier)
        require 'net/http'
        require 'uri'
        require 'json'
        
        uri = URI.parse("https://paygateglobal.com/api/v1/pay")
        
        header = {'Content-Type': 'applocation/json'}
        data = {
            auth_token: TOKEN,
            phone_number: phone,
            amount: amount,
            description: description,
            identifier: identifier
            }
        
        # Create the HTTP objects
        http = Net::HTTP.new(uri.host, uri.port)
        request = Net::HTTP::Post.new(uri.request_uri, header)
        request.body = data.to_json
        
        # Send the request
        response = http.request(request)
    end
end