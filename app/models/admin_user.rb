class AdminUser < ApplicationRecord
  has_many :accounts
  has_many :assignments, through: :accounts

  devise :database_authenticatable, :recoverable, :rememberable, :validatable

  def full_name
    email
  end
end
