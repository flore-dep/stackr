class Tool < ApplicationRecord
  has_many :plans, dependent: :destroy
  has_one_attached :logo

  include PgSearch::Model

  validates :name, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 1 }
  validates :category, presence: true, inclusion: { in: ["Productivity", "Project Management", "Communication", "CRM"] }
  validates :formulas, presence: true
  validates :access_types, presence: true

  pg_search_scope :global_search,
    against: [ :name, :category ],
    associated_against: {
      plans: [ :status ]
    },
    using: {
      tsearch: { prefix: true }
    }

    scope :current_organization_plan, ->(plans) {organization_id: current_user.organization.id}

  #   <%@plans = License.scope.tool.plans
  #   @plan_organization = @plans.where(organization_id: current_user.organization.id)
  #   @teams = @plan_organization.first.teams
  # %>
  #   scope :active_license_per_user, -> (user_id) {where("end_at >= ? AND user_id = ?", Time.current, user_id)}

  #   @licenses_active = License.active_license_per_user(current_user.id).includes(:software)


end
