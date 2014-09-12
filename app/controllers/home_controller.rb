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

  def contact_submit
    if verify_recaptcha
      # Send the contents to admins
      ContactMailer.contact(params[:body]).deliver
      redirect_to contact_path, notice: t('contact.response_sent')
    else
      redirect_to contact_path
    end
  end

  def privacy
    render
  end

  def terms
    render
  end
end
