class CommentDecorator < ApplicationDecorator
  delegate_all

  def is_banned?
    BannedIp.where(ip: object.user_ip).exists?
  end

  def banned_ip
    BannedIp.find_by(ip: object.user_ip)
  end
end
