class Organization < ApplicationRecord
  has_many :teams, dependent: :destroy
  has_many :plans, dependent: :destroy
  has_many :users, through: :teams

  validates :name, presence: true, uniqueness: true, length: { minimum: 3 }
end
