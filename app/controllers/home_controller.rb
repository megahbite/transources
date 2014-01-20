class HomeController < ApplicationController
  def index
    @categories = ActsAsTaggableOn::Tag
    .includes(:taggings)
    .where(taggings: { context: 'categories' })
    .distinct
  end
end
