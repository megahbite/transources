class ContactMailerPreview < ActionMailer::Preview
  def contact
    ContactMailer.contact("Test body\nLine 2")
  end
end
