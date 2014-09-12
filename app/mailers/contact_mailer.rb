class ContactMailer < ActionMailer::Base
  default from: "admin@megan.geek.nz"
  default subject: "Contact from transources"

  def contact(body)
    @body = body
    mail(to: User.with_role(:admin).pluck(:email))
  end
end
