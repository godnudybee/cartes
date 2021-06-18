NOM_APP = 'ECARTE'
TIMEOUT = 3.minutes

class OtpsController < ApplicationController
    require 'net/http'
    def self.sms_alert(from, to, text)
        #http://cybetcast.net:60001/cgi-bin/sendsms?username=moov&password=moov&from=BHK&to=22899699200&text=BONJOUR
        data =  {
            "username" => "moov",
            "password" => "moov",
            "from" => from,
            "to" => "#{to}",
            "text" => text
        }
        
        uri = URI("http://cybetcast.net:60001/cgi-bin/sendsms")
        uri.query = URI.encode_www_form(data)
        res = Net::HTTP.get_response(uri)

        puts res.body if res.is_a?(Net::HTTPSuccess)
    end

    def self.generate_code
        sprintf("%06d", rand(100..999998))
    end

    def envoi_otp
        le_phone = params["phone"]
        le_code = OtpsController::generate_code
        le_text = "Voici votre code de creation de compte\n #{le_code}"

        @otp = Otp.find_by("phone": le_phone)

        if @otp.nil?
            @otp = Otp.new("phone": le_phone, "code": le_code)
        else
            @otp.code = le_code
        end

        if @otp.save
            OtpsController::sms_alert NOM_APP, le_phone, le_text
            render json: 1
            return
        end

        render json: 0
    end

    def verify_otp
        @otp = Otp.where(phone: params["phone"])
                .where(code: params["code"])
                .where(["updated_at >= ?", DateTime.now - TIMEOUT])
                .where(["updated_at <= ?", DateTime.now]).first        
        
        good = @otp.nil? ? 0 : 1

        render json: good
    end



end