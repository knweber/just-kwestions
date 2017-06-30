require 'bcrypt'

class User < ActiveRecord::Base
  include BCrypt

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/ }, uniqueness: true
  # will this catch/throw an error at the registration level? \/
  validates :password_hash, presence: true, length: { minimum: 8 }

  has_many :questions

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def self.authenticate(email, password)
    @user = User.find_by_email(email)
    return nil if @user == nil

    if @user.password == password
      @user
    else
      nil
    end
  end

end
