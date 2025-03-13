class Tool < ApplicationRecord
  has_many :plans, dependent: :destroy
  has_many :reviews
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
end
