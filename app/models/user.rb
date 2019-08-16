class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

  has_many :user_roles, :dependent => :destroy
  has_many :roles, :through => :user_roles

  def has_role?(role_sym)
  	roles.any? { |r| r.name.underscore.to_sym == role_sym }
  end
end
