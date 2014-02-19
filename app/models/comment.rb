class Comment < ActiveRecord::Base
  include Rakismet::Model
  attr_accessor :anonymous
  belongs_to :resource

  belongs_to :user

  validates_presence_of :resource_id

  rakismet_attrs  author: ->(c) { c.user ? c.user.name : "" }, 
                  author_email: ->(c) { c.user ? c.user.email : "" },
                  comment_type: "comment",
                  content: :text#,
                  #permalink: ->(c) { Rails.application.routes.url_helpers.resource_path(id: c.resource.id, only_path: false) }

end
