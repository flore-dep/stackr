class Organization < ApplicationRecord
  has_many :users, through: :teams
  has_many :teams, dependent: :destroy

  validates :name, presence: true, uniqueness: true, length: { minimum: 3 }
end
