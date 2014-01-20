class CommentPolicy < ApplicationPolicy
  attr_reader :user, :comment

  class Scope < Struct.new(:user, :scope)
    def resolve
      scope
    end
  end

  def initialize(user, comment)
    @user = user
    @comment = comment
  end

  def create?
    user.has_role?(:admin) or user.has_role?(:user)
  end

  def destroy?
    user.has_role?(:admin) or comment.user == user
  end
end
