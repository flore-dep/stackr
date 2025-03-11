class Plan < ApplicationRecord
  belongs_to :organization
  belongs_to :tools
end
