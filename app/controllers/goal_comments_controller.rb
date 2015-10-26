class GoalCommentsController < ApplicationController
  def create
    @goal_comment = GoalComment.new(goal_comment_params)
    @goal_comment.commenter_id = current_user.id

    if @goal_comment.save
      redirect_to goal_url(@goal_comment.goal)
    else
      flash[:errors] = @goal_comment.errors.full_messages
      redirect_to goal_url(@goal_comment.goal)
    end
  end

  def update
  end

  def destroy
  end

  private
    def goal_comment_params
      params.require(:goal_comment).permit(:goal_id, :body)
    end
end
