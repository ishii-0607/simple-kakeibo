class Cost < ApplicationRecord

  belongs_to :income, optional: true
  belongs_to :fixedcost, optional: true
  belongs_to :variablecost, optional: true

end
