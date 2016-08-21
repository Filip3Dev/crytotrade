class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

    mount_uploader :avatar , MediaUploader     
         
    has_many :messages
         
    def ensure_authentication_token
		if authentication_token.blank?
			self.authentication_token=generate_authentication_token
		end

	end

	def self.generate_authentication_token
		loop do 
			token=Devise.friendly_token
			break token unless User.find_by(authentication_token:token)	
		end
		
	end

	def data_simplify()
    return {
      id: self.id,
      email: self.email,
      authentication_token: self.authentication_token,
      name: self.name,
      
      
      created_at: self.created_at,
      updated_at: self.updated_at
    }
  end
end
