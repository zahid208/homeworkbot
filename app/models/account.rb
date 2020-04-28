class Account < ApplicationRecord
  belongs_to :admin_user
  has_many :assignments
  has_many :filters
  has_many :transactions

  validates :email, :password, :bid_content, presence: true
  validates :email, uniqueness: true
end
