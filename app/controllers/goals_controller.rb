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
    render :show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def goal_params
    params.require(:goal).permit(:title, :description, :status, :private)
  end
end
