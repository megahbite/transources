class Resource < ActiveRecord::Base
  attr_accessible :address_line_1, :address_line_2, :country, :category_ids, :description, :title, :town, :lat, :long

  has_and_belongs_to_many :categories

  has_many :comments, order: "created_at DESC"

  validates :title, presence: true
  validates :description, presence: true
  validates :address_line_1, presence: true
  validates :town, presence: true
  validates :country, presence: true

  def join_address(join_string)
    [address_line_1, address_line_2, town, country].join(join_string)
  end
end
