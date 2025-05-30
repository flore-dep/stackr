class Plan < ApplicationRecord
  belongs_to :organization
  belongs_to :tool
  has_many :scopes
  has_many :licenses
  has_many :teams, through: :organization

  validates :tool, presence: true, uniqueness: { scope: :organization }
  validates :organization, presence: true
  validates :formula, presence: true
  validates :status, presence: true, inclusion: { in: %w[Approved Pending Declined]}

  validate :formula_in_tool_formulas


  scope :current_organization_plan, ->(tool, user) {Plan.find_by(tool_id: "#{tool.id}", organization_id: "#{user.organization.id}")}
  # scope :current_organization_plan, ->(tool, user) {where("tool_id = ? AND organization_id = ?", tool, user.organization.id)}

  private

  def formula_in_tool_formulas
    unless tool && formula && JSON.parse(tool.formulas).to_a.include?(formula)
      errors.add(:formula, "must be included within tool formulas")
    end
  end
end
