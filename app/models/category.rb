class Category < ActiveRecord::Base
  include Authority::Abilities
  has_and_belongs_to_many :resources

  validates_presence_of :name
end
