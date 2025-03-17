class Scope < ApplicationRecord
  belongs_to :team
  belongs_to :plan
  has_many :licenses
  has_one :organization, through: :team
  has_one :tool, through: :plan

  validates :plan, presence: true, uniqueness: { scope: :team}
  validates :team, presence: true

  scope :max_end_date, ->(scope) {select("max(licenses.end_date) as end_date").joins(:licenses).where(id: scope.id)}

end
