class Plan < ApplicationRecord
  has_many :scopes
  has_many :licenses

  belongs_to :organization
  belongs_to :tool
end
