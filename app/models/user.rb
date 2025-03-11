class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :team
  has_many :licenses, dependent: :destroy
  has_one :organization, through: :team

  validates :first_name, presence: true, length: { minimum: 1}
  validates :last_name, presence: true, length: { minimum: 1}
  validates :last_name, uniqueness: { scope: :first_name }
  validates :role, presence: true, inclusion: { in: %w[Founder Manager Employee]}
  validates :start_date, presence: true
  validate :not_before

  private

  def not_before
    if start_date.present? && end_date.present? && end_date <= start_date
      errors.add(:end_date, "end date must be after start date")
    end
  end

end
