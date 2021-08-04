class Category < ApplicationRecord
  has_many :tasks
  before_save { name.downcase! }
  validates :name, presence: true, uniqueness: { case_sensitive: false}
end