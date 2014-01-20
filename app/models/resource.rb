class Resource < ActiveRecord::Base
  acts_as_taggable_on :categories

  has_many :comments, -> { order(created_at: :desc) }

  validates_presence_of :title, :description, :address_line_1, :town, :country

  def join_address(join_string)
    [address_line_1, address_line_2, town, country].join(join_string)
  end
end
