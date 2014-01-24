class TagsController < ApplicationController
  def categories
    @categories = ActsAsTaggableOn::Tag
    .includes(:taggings)
    .where(taggings: { context: 'categories' })
    .distinct

    render json: @categories, status: :ok
  end
end