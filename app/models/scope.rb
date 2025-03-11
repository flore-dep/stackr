class Scope < ApplicationRecord
  belongs_to :team
  belongs_to :tool
  belongs_to :plan
end
