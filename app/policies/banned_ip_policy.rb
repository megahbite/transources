class BannedIpPolicy < ApplicationPolicy
  attr_reader :user, :banned_ip

  class Scope < Struct.new(:user, :scope)
    def resolve
      scope
    end
  end

  def initialize(user, banned_ip)
    @user = user
    @banned_ip = banned_ip
  end

  def create
    user.has_role?(:admin)
  end

  def destroy
    user.has_role?(:admin)
  end
end
