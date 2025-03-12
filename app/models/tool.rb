class Tool < ApplicationRecord
  has_many :plans, dependent: :destroy
  has_one_attached :logo

  validates :name, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 1 }
  validates :category, presence: true, inclusion: { in: ["Productivity", "Project Management", "Communication", "CRM"] }
  validates :formulas, presence: true
  validates :access_types, presence: true

end
