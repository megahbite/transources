class HomeController < ApplicationController
  def index
    @categories = ActsAsTaggableOn::Tag
    .includes(:taggings)
    .where(taggings: { context: 'categories' })
    .distinct
  end

  def about
    render
  end

  def contact
    render
  end

  def privacy
    render
  end

  def terms
    render
  end
end
