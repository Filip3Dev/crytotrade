class Service::MessagesController < Service::ApiController
	before_action :set_message, only: [:destroy, :update]

	def messages
	
		if authenticate
				
			@message=Message.all

			render json: {
				success: true,
				info: "Mensagem Enviada",
				data: @message
				}

		else
				render status: :unprocessable_entity, json: {
			        success: false,
			        info: "Token Invalido",
			        data: {}
			     }
		end		
	end

	def message_category
	
		if authenticate
				
			@message=Message.where(category: params[:category])

			render json: {
				success: true,
				info: "Mensagens",
				data: @message
			}
		end
	end

	
	def send_message
		
		if authenticate
		
			@message=Message.create(message_params)

			if @message.save
				render json: {
					successs: true,
					info: "Mensagem Enviada",
					data: @message
				}
			else
				render status: :unprocessable_entity, json: {
			        success: false,
			        info: @message.errors.full_messages.join(", "),
			        data: {}
			     }
			end
		else
				render status: :unprocessable_entity, json: {
			        success: false,
			        info: "Token Invalido",
			        data: {}
			     }
		end

	end

	def destroy
		if authenticate
			if @message.destroy
				render json: {
					successs: true,
					info: "Destruido",
					data: {}

				}
			else
				render status: :unprocessable_entity, json: {
			        success: false,
			        info: @message.errors.full_messages.join(", "),
			        data: {}
			     }
			end			

		end				
	end

   def message_params
      params.require(:message).permit!
   end

	private
	def authenticate
     
  	 	User.find_by(authentication_token: params[:token])
     
  	end

  	private
  	def set_message
      @message = Message.find(params[:id])
   	end

end 
