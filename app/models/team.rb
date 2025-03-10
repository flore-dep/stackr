class Team < ApplicationRecord
  has_many :users
  belongs_to :organization

  validates :name, presence: :true, length: {minimum: 3}
  validates :organization, presence: true
  validates :name, uniqueness: { scope: :organization }

end
