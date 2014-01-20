class Comment < ActiveRecord::Base
  attr_accessor :anonymous
  belongs_to :resource

  belongs_to :user

  validates_presence_of :resource_id
end
