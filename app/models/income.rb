class Income < ApplicationRecord

  has_one :cost, dependent: :destroy
  belongs_to :user, optional: true

  validates :name, presence: true
  validates :value, presence: true

end
