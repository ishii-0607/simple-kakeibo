class FixedcostsController < ApplicationController

  def index
    @fixedcosts = current_user.fixedcosts.order(created_at: :asc)
  end

  def show
    @fixedcost = Fixedcost.find(params[:id])
  end

  def new
    @fixedcost = Fixedcost.new
  end

  def edit
    @fixedcost = Fixedcost.find(params[:id])
  end

  def create
    fixedcost = Fixedcost.new(fixedcost_params)
    fixedcost.user_id = current_user.id
    if fixedcost.save
      Cost.create!(fixedcost_id: fixedcost.id, value: fixedcost.value, start_time: fixedcost.start_time, user_id: current_user.id)
      flash[:notice] = "固定費科目を登録しました"
      redirect_to fixedcosts_path
    else
      render :new
    end
  end

  def update
    @fixedcost = Fixedcost.find(params[:id])
    if @fixedcost.update(fixedcost_params)
      flash[:notice] = "固定費科目を更新しました"
      redirect_to fixedcosts_path
    else
      render :edit
    end
  end

  def destroy
    @fixedcost = Fixedcost.find(params[:id])
    @fixedcost.destroy
    flash[:notice] = "科目を削除しました"
    redirect_to fixedcosts_path
  end

  private

  def fixedcost_params
    params.require(:fixedcost).permit(:name, :description, :start_time, :value)
  end

end
