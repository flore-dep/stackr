class Organization < ApplicationRecord
  has_many :teams, dependent: :destroy
  has_many :plans, dependent: :destroy
  has_many :users, through: :teams
  has_many :licenses, through: :plans
  has_many :tools, through: :plans

  validates :name, presence: true, uniqueness: true, length: { minimum: 3 }

end
