class Resource < ActiveRecord::Base
  attr_accessible :address_line_1, :address_line_2, :category, :country, :description, :title, :town

  validates :title, presence: true
  validates :description, presence: true
  validates :category, presence: true
  validates :address_line_1, presence: true
  validates :town, presence: true
  validates :country, presence: true
end
