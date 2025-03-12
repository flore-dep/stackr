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


  scope :current_organization_plan, ->(tool, user) {where("tool_id = ? AND organization_id = ?", tool, user.organization.id)}
  # scope :active_license_per_user, -> (user_id) {where("end_at >= ? AND user_id = ?", Time.current, user_id)}


  #   <%@plans = License.scope.tool.plans
  #   @plan_organization = @plans.where(organization_id: current_user.organization.id)
  #   @teams = @plan_organization.first.teams
  # %>
  #   scope :active_license_per_user, -> (user_id) {where("end_at >= ? AND user_id = ?", Time.current, user_id)}

  #   @licenses_active = License.active_license_per_user(current_user.id).includes(:software)


  private

  def formula_in_tool_formulas
    unless tool && formula && JSON.parse(tool.formulas).to_a.include?(formula)
      errors.add(:formula, "must be included within tool formulas")
    end
  end
end
