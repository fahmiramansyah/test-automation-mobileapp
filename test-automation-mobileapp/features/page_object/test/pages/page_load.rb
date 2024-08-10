class Page 

    def initialize(tags)
        @tags = tags
    end

    def load(android=nil, ios=nil)
        if @tags.include? '@android'
            return android
        elsif @tags.include? '@ios'
            return ios
        end       
    end  
    
    def home_page
        load(HomePageAndroid.new, HomePageIos.new)
    end

end
