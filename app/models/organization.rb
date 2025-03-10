class Organization < ApplicationRecord
  has_many :users, through: :teams
  has_many :teams
end
