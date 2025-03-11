class License < ApplicationRecord
  belongs_to :plan
  belongs_to :user
  belongs_to :scope
end
