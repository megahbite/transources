require 'uri'
class Resource < ActiveRecord::Base
  acts_as_taggable_on :categories

  has_many :comments, -> { order(created_at: :desc) }
  has_many :scores

  validates_presence_of :title, :description, :address_line_1, :town, :country

  validate :website_is_a_url

  def website_is_a_url
    return unless self.website.present?
    uri = URI.parse(self.website)
    unless uri.is_a?(URI::HTTP)
      self.errors[:website] << "must be a HTTP/S link"
    end
  rescue URI::InvalidURIError
    self.errors[:website] << "is not a URL"
  end
end
