class Team < ApplicationRecord
  belongs_to :organization
  has_many :users
  has_many :scopes
  has_many :licenses, through: :scopes
  has_many :plans, -> { distinct }, through: :licenses
  has_many :tools, -> { distinct }, through: :plans

  include PgSearch::Model

  validates :name, presence: true, uniqueness: { scope: :organization }, length: {minimum: 1}
  validates :organization, presence: true

  pg_search_scope :team_search,
    against: [ :name ],
    associated_against: {
      tools: [ :name ],
    },
    using: {
      tsearch: { prefix: true }
    }

  def cost
    self.licenses.sum do |license|
      if Time.now.between?(license.start_date, license.end_date) && license.status == "Approved"
        license.plan.formula[1]
      else
        0
      end
    end
  end

  # def tools
  #   tools = self.licenses.map do |license|
  #     license.tool
  #   end
  #   tools.uniq
  # end

  # def plans
  #   plans = self.licenses.map do |license|
  #     license.plan
  #   end
  #   plans.uniq
  # end

end
