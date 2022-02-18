class IncomesController < ApplicationController

  def index
    @incomes = Income.all.order(created_at: :asc)
  end

  def show
    @income = Income.find(params[:id])
  end

  def new
    @income = Income.new
  end

  def edit
    @income = Income.find(params[:id])
  end

  def create
    @income = Income.new(income_params)
    if @income.save
      flash[:notice] = "収入科目を登録しました"
      redirect_to incomes_path
    else
      render :new
    end
  end

  def update
    @income = Income.find(params[:id])
    if @income.update(income_params)
      flash[:notice] = "収入科目を更新しました"
      redirect_to incomes_path
    else
      render :edit
    end
  end

  def destroy
    @income = Income.find(params[:id])
    @income.destroy
    flash[:notice] = "科目を削除しました"
    redirect_to incomes_path
  end

  private

  def income_params
    params.require(:income).permit(:name, :description, :year_month, :value)
  end

end
