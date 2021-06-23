module Savingimages

    def self.create_file_from_upload_data(data, dir)
        if ! (File.directory? dir)
            puts "#{dir} pas un dossier"
            return false
        end
        
        #if data.original_filename = ""
        #    puts "original_filename pas là"
        #    return false
        #end
        if data.tempfile == nil
            puts "tempfile pas là"
            return false
        end
        name = File.basename(data.original_filename)
        ext = File.extname(data.original_filename)
        name = name.split(ext)[0]
        filename = "#{dir}/#{name}_#{sprintf("%05d", (rand 0..99999))}#{ext}"
        
        
        in_file = data.tempfile.open()
        out_file = File.new(filename, "wb")
        #...
        x = ""
        while in_file.read(1, x)
            out_file.putc x
        end
        #...
        out_file.close

        File.basename(filename)
    end

    def self.user_img_dir        
        "#{Dir.getwd}/app/assets/images/from_users"
    end

    def self.user_img_url(filename)        
        "/from_users/#{filename}"
    end

    def self.asset_exists?(path)
        if Rails.env.production?  
            Rails.application.assets_manifest.find_sources(path) != nil
        else
            Rails.application.assets.find_asset(path) != nil
        end
    end
end