class HomesController < ApplicationController

  def top
    @costs = Cost.all
  end

end
