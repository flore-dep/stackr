class Team < ApplicationRecord
  belongs_to :organization
  has_many :users
  has_many :scopes
  has_many :licenses, through: :scopes
  has_many :plans, through: :organization

  validates :name, presence: :true, length: {minimum: 3}
  validates :organization, presence: true
  validates :name, uniqueness: { scope: :organization }

end
