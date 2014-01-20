class ResourcePolicy < ApplicationPolicy
  attr_reader :user, :resource

  class Scope < Struct.new(:user, :scope)
    def resolve
      scope
    end
  end

  def initialize(user, resource)
    @user = user
    @resource = resource
  end

  def create?
    default
  end

  def new?
    default
  end

  def update?
    default
  end

  def edit?
    default
  end

  def destroy?
    default
  end 

private
  def default
    user.has_role?(:admin) or user.has_role?(:user)
  end
end
