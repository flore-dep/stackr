class Plan < ApplicationRecord
  belongs_to :organization
  belongs_to :tool
  has_many :scopes
  has_many :licenses
  has_many :teams, through: :organization

  validates :tool, presence: true, uniqueness: { scope: :organization }
  validates :organization, presence: true
  validates :formula, presence: true
  validates :status, presence: true
end
