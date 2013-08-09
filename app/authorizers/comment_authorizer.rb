class CommentAuthorizer < ApplicationAuthorizer
  def self.creatable_by?(user)
    user.has_role?(:admin) or user.has_role?(:user)
  end

  def self.destroyable_by?(user)
    user.has_role?(:admin)
  end
end