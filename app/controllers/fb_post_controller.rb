class FbPostController < ApplicationController
 

  def index
     session[:oauth] = Koala::Facebook::OAuth.new(Settings.Facebook.facebook_app_id, Settings.Facebook.facebook_secret, post_url)
	 @auth_url =  session[:oauth].url_for_oauth_code(:permissions => "publish_actions")

	 redirect_to  @auth_url
		#puts session.to_s + "<<< session"
 
  end

  def post
     if params[:code]
  		# acknowledge code and get access token from FB
  		  @oauth=Koala::Facebook::OAuth.new(Settings.Facebook.facebook_app_id, Settings.Facebook.facebook_secret, post_url)
		  @access_token = @oauth.get_access_token(params[:code])
			

		 # auth established, now do a graph call:
   
      #debugger
      @graph = Koala::Facebook::API.new(@access_token)
      
      begin
          @graph.put_connections("me", "feed", message: "ruby on rails facebook test")
      rescue => e
          if(e.fb_error_type == "OAuthException")
            flash[:alert] = "Already Posted"
          end
      end	

     
     end

  end
  
  def postOver
  	
  end


  


end
