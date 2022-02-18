class VariablecostsController < ApplicationController

  def index
    @variablecosts = Variablecost.all.order(created_at: :asc)
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
    @variablecost = Variablecost.new(variablecost_params)
    if @variablecost.save
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
    params.require(:variablecost).permit(:name, :description, :year_month, :value)
  end

end
