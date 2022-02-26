class IncomesController < ApplicationController

  def index
    @incomes = current_user.incomes.order(created_at: :asc)
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
    income = Income.new(income_params)
    income.user_id = current_user.id
    if income.save
      Cost.create!(income_id: income.id, value: income.value, start_time: income.start_time, user_id: current_user.id)
      #cost.user_id = current_user.id
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
    params.require(:income).permit(:name, :description, :start_time, :value)
  end

end
