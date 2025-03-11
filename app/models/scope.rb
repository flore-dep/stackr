class Scope < ApplicationRecord
  has_many :licenses

  belongs_to :team
  belongs_to :tool
  belongs_to :plan

  has_one :organization, through: :team
  has_one :tool, through: :plan

end
