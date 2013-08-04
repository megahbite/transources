class Comment < ActiveRecord::Base
  attr_accessor :anonymous
  attr_accessible :resource_id, :score, :text, :user_id

  belongs_to :resource

  belongs_to :user

  validates :resource_id, presence: true
end
