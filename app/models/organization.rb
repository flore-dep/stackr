class Organization < ApplicationRecord
  has_many :users, through: :teams
  has_many :teams

  validates :name, presence: true, uniqueness: true, length: { minimum: 3 }
end
