class Attach < ActiveRecord::Base
  mount_uploader :filename, AttachUploader
  belongs_to :attachable, :polymorphic => true
end
