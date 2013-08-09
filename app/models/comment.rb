class Comment < ActiveRecord::Base
  include Authority::Abilities

  self.authorizer_name = "CommentAuthorizer"
  
  attr_accessor :anonymous
  belongs_to :resource

  belongs_to :user

  validates_presence_of :resource_id
end
