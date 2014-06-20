class Score < ActiveRecord::Base
  has_many :resources
  has_many :users

  validates :value, numericality: { greater_than: 0, less_than_or_equal_to: 5 }
end
