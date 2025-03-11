class Plan < ApplicationRecord
  belongs_to :organizations
  belongs_to :tools
end
