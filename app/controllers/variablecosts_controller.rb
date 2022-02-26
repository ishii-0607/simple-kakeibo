class VariablecostsController < ApplicationController

  def index
    @variablecosts = current_user.variablecosts.order(created_at: :asc)
  end

  def show
    @variablecost = Variablecost.find(params[:id])
  end

  def new
    @variablecost = Variablecost.new
  end

  def edit
    @variablecost = Variablecost.find(params[:id])
  end

  def create
    variablecost = Variablecost.new(variablecost_params)
    variablecost.user_id = current_user.id
    if variablecost.save
      Cost.create!(variablecost_id: variablecost.id, value: variablecost.value, start_time: variablecost.start_time, user_id: current_user.id)
      flash[:notice] = "変動費科目を登録しました"
      redirect_to variablecosts_path
    else
      render :new
    end
  end

  def update
    @variablecost = Variablecost.find(params[:id])
    if @variablecost.update(variablecost_params)
      flash[:notice] = "変動費科目を更新しました"
      redirect_to variablecosts_path
    else
      render :edit
    end
  end

  def destroy
    @variablecost = Variablecost.find(params[:id])
    @variablecost.destroy
    flash[:notice] = "科目を削除しました"
    redirect_to variablecosts_path
  end

  private

  def variablecost_params
    params.require(:variablecost).permit(:name, :description, :start_time, :value)
  end

end
