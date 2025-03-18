class License < ApplicationRecord
  STATUS = ["Approved", "Pending", "Declined"]
  ACCESS_TYPE = ["User", "Admin"]
  belongs_to :plan
  belongs_to :user
  belongs_to :scope, optional: true
  has_one :team, through: :scope
  has_one :organization, through: :team
  has_one :tool, through: :plan


  validates :user, presence: true
  validates :plan, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :status, presence: true, inclusion: { in: STATUS}
  validates :access_type, presence: true, inclusion: { in: ACCESS_TYPE }

  validate :access_type_in_tool_access_types
  validate :end_date_after_start_date
  validate :no_dates_overlap

  private

  def access_type_in_tool_access_types
    unless plan && access_type && plan.tool.access_types.include?(access_type)
      errors.add(:access_type, "must be included within access types")
    end
  end

  def end_date_after_start_date
    if start_date && end_date && end_date <= start_date
      errors.add(:end_date, "must be after start date")
    end
  end

  def no_dates_overlap
    return unless user && plan && start_date && end_date

    conflicts = License.where(user: user, plan: plan, status: ["Approved", "Pending"]).where.not(id: id).none? do |license|
      license.start_date < end_date && license.end_date > start_date
    end

    unless conflicts
      errors.add(:start_date, "must not have overlapping dates with another license for the same user and plan")
    end
  end

end
