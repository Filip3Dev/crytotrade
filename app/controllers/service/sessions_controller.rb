class Service::SessionsController < Service::ApiController
	def create
		puts "***************|Login|*******************"
	    @user = User.find_by_email(params[:user][:email])
	    if @user.present? && @user.valid_password?(params[:user][:password])
	      puts "***************|user presente|*******************"
	      @user.update_column(:authentication_token, User.generate_authentication_token)
	      warden.set_user @user
	      render status: 200, json: {
	        
	        success: true,
	        user: @user
	         
	      }
	    else
	      puts "***************|user error|*******************"
	      render :status => 401, json: {
	          success: false,
	          info: "",
	          data: {}
	      }
	    end	
	end

	def logout

	end
end