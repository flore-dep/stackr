class License < ApplicationRecord
  belongs_to :plan
  belongs_to :user
  belongs_to :scope
  has_one :team, through: :scope
  has_one :organization, through: :team
  has_one :tool, through: :plan

end
