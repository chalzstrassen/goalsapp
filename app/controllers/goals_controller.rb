class GoalsController < ApplicationController
  before_action :require_correct_credentials, only: [:edit, :update, :destroy]

  def show
    @goal = Goal.find(params[:id])
  end

  def new
    @goal = Goal.new
  end

  def edit
    @goal = Goal.find(params[:id])
  end

  def update
    goal = Goal.find(params[:id])
    if goal.update(goal_params)
      redirect_to user_url(goal.user)
    else
      flash.now[:errors] = goal.errors.full_messages
      render :edit
    end

  end

  def create
    goal = Goal.new(goal_params)
    goal.user_id = current_user.id
    if goal.save
      redirect_to user_url(goal.user_id)
    else
      flash.now[:errors] = goal.errors.full_messages
      render :new
    end
  end

  def destroy
    goal = Goal.find(params[:id])
    goal.destroy
    redirect_to user_url(goal.user_id)
  end

  def goal_params
    params.require(:goal).permit(:title, :body, :privacy, :completed)
  end

  def require_correct_credentials
    unless current_user.id == Goal.find(params[:id]).user_id
      redirect_to root_url
    end
  end

end
