class GoalsController < ApplicationController

  def index
    @goals = Goal.all
    render :index
  end

  def new
    @goal = Goal.new
    render :new
  end

  def create
    @goal = Goal.new(goal_params)
    @goal.user_id = current_user.id

    if @goal.save
      redirect_to goal_url(@goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @goal = Goal.find(params[:id])
    if current_user != @goal.user
      flash[:errors] = "Permission denied"
      redirect_to goals_url
    else
      render :show
    end
  end

  def edit
    @goal = Goal.find(params[:id])
    render :edit
  end

  def update
    @goal = Goal.find(params[:id])

    if @goal.update!(goal_params)
      redirect_to goal_url(@goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
  end

  private
  def goal_params
    params.require(:goal).permit(:title, :description, :status, :private)
  end
end
