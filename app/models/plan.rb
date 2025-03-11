class Plan < ApplicationRecord
  belongs_to :organization
  belongs_to :tool
  has_many :scopes
  has_many :licenses
end
