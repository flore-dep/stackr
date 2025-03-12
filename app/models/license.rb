class License < ApplicationRecord
  belongs_to :plan
  belongs_to :user
  belongs_to :scope, optional: true
  has_one :team, through: :scope
  has_one :organization, through: :team
  has_one :tool, through: :plan


  validates :user, presence: true
  validates :plan, presence: true
  validates :start_date, presence: true
  validates :status, presence: true, inclusion: { in: %w[Approved Pending Declined]}
  validates :access_type, presence: true

  validate :no_open_license, on: :create
  validate :end_date_after_start_date
  validate :new_license_start_date_after_or_equal_last_license_end_date, on: :create
  validate :access_type_in_tool_access_types

  private

  def end_date_after_start_date
    if start_date && end_date && end_date <= start_date
      errors.add(:end_date, "must be after start date")
    end
  end

  def no_open_license
    if user && plan && License.where(user: user, plan: plan).where(end_date: nil).exists?
      errors.add(:id, "must be created when no open license for the same user")
    end
  end

  def new_license_start_date_after_or_equal_last_license_end_date
    max_end_date = License.where(user: user, plan: plan).maximum(:end_date)
    if user && plan && start_date && max_end_date && start_date < max_end_date
      errors.add(:end_date, "must be after or equal the last end date")
    end
  end

  def access_type_in_tool_access_types
    unless plan && access_type && plan.tool.access_types.include?(access_type)
      errors.add(:access_type, "must be included within access types")
    end
  end
end
