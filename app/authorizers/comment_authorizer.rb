class CommentAuthorizer < ApplicationAuthorizer
  def self.creatable_by?(user)
    user.has_role?(:admin) or user.has_role?(:user)
  end

  def self.destroyable_by?(user)
    user.has_role?(:admin)
  end

  def destroyable_by?(user)
    resource.user == user
  end
end