class Message < ActiveRecord::Base
	mount_uploader :media, MediaUploader

	belongs_to :user
end
