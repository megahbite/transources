class ResourceAuthorizer < ApplicationAuthorizer
  def self.default(adjective, user)
    user.has_role?(:admin) or user.has_role?(:user)
  end
end