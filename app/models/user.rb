class User < ActiveRecord::Base
  # devise plugin handles authentication
  devise :authenticatable, :confirmable, :lockable, :recoverable,
         :rememberable, :registerable, :trackable, :timeoutable, :validatable

  attr_accessible :email, :password, :password_confirmation
end
