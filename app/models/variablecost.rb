class Variablecost < ApplicationRecord

  has_one :cost, dependent: :destroy
  belongs_to :user, optional: true

end
