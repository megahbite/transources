class Resource < ActiveRecord::Base
  acts_as_taggable_on :categories

  has_many :comments, -> { order(created_at: :desc) }
  has_many :scores

  validates_presence_of :title, :description, :address_line_1, :town, :country
end
