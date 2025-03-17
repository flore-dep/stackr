class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :team
  has_many :licenses, dependent: :destroy
  has_many :plans, through: :licenses

  has_one :organization, through: :team

  validates :first_name, presence: true, length: { minimum: 1}
  validates :last_name, presence: true, length: { minimum: 1}
  validates :last_name, uniqueness: { scope: :first_name }
  validates :role, presence: true, inclusion: { in: %w[Founder Manager Employee]}
  validates :start_date, presence: true
  validate :not_before

  scope :active, -> { where('end_date IS NULL OR end_date >= ?', Date.today) }

  def tools
    tools = self.licenses.map do |license|
      license.tool
    end
    tools.uniq
  end

  def plans
    plans = self.licenses.map do |license|
      license.plan
    end
    plans.uniq
  end

  def active_for_authentication?
    super && (end_date.nil? || end_date >= Date.today)
  end

  private

  def not_before
    if start_date.present? && end_date.present?
      if end_date <= start_date
        errors.add(:end_date, "end date must be after start date")
      end
    end
  end
end
