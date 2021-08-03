class Category < ApplicationRecord
  has_many :tasks
  before_save { name.downcase! }
  belongs_to :user
  validates :name, presence: true, uniqueness: { case_sensitive: false}
end