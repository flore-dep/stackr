class Plan < ApplicationRecord
  belongs_to :organization
  belongs_to :tool
end
