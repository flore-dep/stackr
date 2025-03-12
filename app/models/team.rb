class Team < ApplicationRecord
  belongs_to :organization
  has_many :users
  has_many :scopes
  has_many :licenses, through: :scopes
  has_many :plans, through: :organization

  validates :name, presence: true, uniqueness: { scope: :organization }, length: {minimum: 1}
  validates :organization, presence: true
end
