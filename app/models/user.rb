class User < ApplicationRecord
  has_many :categories, dependent: :destroy

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true
  validates :firstname, presence: true
  has_secure_password
end