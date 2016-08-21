class Service::UsersController < Service::ApiController
	before_action :set_message, only: [:destroy, :update]


	def create
		@user=User.create(users_params)

		if @user.save
			render json: {
				successs: true,
				info: "Usuario Cadastrado",
				data: @user

			}
		else
			render status: :unprocessable_entity, json: {
		        success: false,
		        info: @user.errors.full_messages.join(", "),
		        data: {}
		     }
		end			
	end

	def update

		if authenticate
		@user=User.find(params[:id])

			if @user.update(users_params)
				render json: {
					successs: true,
					info: "Usuario Cadastrado",
					data: @user

				}
			else
				render status: :unprocessable_entity, json: {
			        success: false,
			        info: @user.errors.full_messages.join(", "),
			        data: {}
			     }
			end			

		end		
	end

	def destroy
	
		if authenticate
		@user=User.find(params[:id])

			if @user.destroy
				render json: {
					successs: true,
					info: "Destruido",
					data: {}

				}
			else
				render status: :unprocessable_entity, json: {
			        success: false,
			        info: @user.errors.full_messages.join(", "),
			        data: {}
			     }
			end			

		end				
	end


  protected
  def authenticate
     
     User.find_by(authentication_token: params[:token])
     
  end

  def set_message
      @message = Message.find(params[:id])
   end

   private
   def users_params
      params.require(:user).permit!
   end
end