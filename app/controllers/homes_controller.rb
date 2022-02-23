class HomesController < ApplicationController

  def top
    @costs = current_user.costs
  end

end
