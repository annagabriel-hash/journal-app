class Task < ApplicationRecord
  belongs_to :category, optional: true
  belongs_to :user
end
