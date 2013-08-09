class User < ActiveRecord::Base
  include Authority::UserAbilities

  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  after_create :add_default_role

private
  def add_default_role
    self.add_role :user
  end
  
end
