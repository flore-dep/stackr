class Team < ApplicationRecord
  belongs_to :organization
  has_many :users
  has_many :scopes
  has_many :licenses, through: :scopes
  has_many :plans, -> { distinct }, through: :licenses
  has_many :tools, -> { distinct }, through: :plans

  validates :name, presence: true, uniqueness: { scope: :organization }, length: {minimum: 1}
  validates :organization, presence: true


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
