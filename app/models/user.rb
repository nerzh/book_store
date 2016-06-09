class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  has_many :reviews,          dependent: :delete_all
  has_many :ratings,          dependent: :delete_all

  this_is_user

  after_create :set_role

  def admin?
    self.has_role? :admin
  end

  def user?
    self.has_role? :user
  end

  def self.find_for_facebook_oauth(token)
    if user = User.where(email: token.info.email).first
      return user
    else
      User.create!(email: token.info.email, password: Devise.friendly_token[0,20])
    end
  end

  private

  def set_role
    self.add_role :user
  end

end