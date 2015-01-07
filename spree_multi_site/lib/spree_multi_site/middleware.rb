module SpreeMultiSite
  class Middleware
    def initialize(app)
      @app = app
    end
 

    def call(env)
      request = Rack::Request.new(env)
      resource_extension = request.path[/\.[\w]+/]
      # ignore .css, .js, .img, except .json
      if resource_extension.nil? || resource_extension=='.json' 
        site = get_site_from_request(request)
        Spree::Site.current = ( site || Spree::Site.first)
      end
      status, headers, body = @app.call(env)      
      [status, headers, body]
    end
    
    def get_site_from_request( request )
      site = nil      
      # test.david.com => localhost:8080/?n=test.david.com
      # our domain is www.dalianshops.com 
      if (request.params['n'].is_a? String) && (request.params['n'].end_with? SpreeMultiSite::Config.domain ) # support short_name.dalianshops.com 
        short_name = request.params['n'].split('.').first
        site = Spree::Site.find_by_short_name(short_name)        
      end

      if site.blank?  
        # support domain, ex. www.david.com
        # apache rewrite test.david.com => localhost:8080/?n=test.david.com, request.host is 'test.david.com'
        # TODO should use public_suffix_service handle example.com.cn
        site = Spree::Site.find_by_domain(request.host) 
      end
      
      if(( Rails.env !~ /prduction/ ) && ( site.blank? ) )  
        # for development or test, enable get site from cookie
        # string and symbol both OK.  cookie.domain should be exactly same as host, www.domain.com != domain.com
        # disable domain, some site have no domain, short_name always exists. 
        #cookie_domain = request.cookies['_dalianshops_domain'] 
        #if cookie_domain.present?
        #  site = Spree::Site.find_by_domain( cookie_domain )
        #end        
        cookie_domain = request.cookies['_dalianshops_short_name'] 
        if cookie_domain.present?
          site = Spree::Site.find_by_short_name( cookie_domain )
        end        
      end
      site
    end

  end
end