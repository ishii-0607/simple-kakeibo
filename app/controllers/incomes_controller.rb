class IncomesController < ApplicationController

  def index
    @incomes = Income.all.order(created_at: :asc)
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
  end

  def update
  end

  def destroy
  end

end
