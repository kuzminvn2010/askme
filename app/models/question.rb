class Question < ApplicationRecord

  belongs_to :user

  validates :user, presence: true
  validates :text , length: {maximum: 255}, presence: true
end
