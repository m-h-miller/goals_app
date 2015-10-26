class UserCommentsController < ApplicationController
  def create
    @user_comment = UserComment.new(user_comment_params)
    @user_comment.commenter_id = current_user.id

    flash[:errors] = @user_comment.errors.full_messages unless @user_comment.save

    redirect_to user_url(@user_comment.user)
  end

  def update
  end

  def destroy
  end

  private
    def user_comment_params
      params.require(:user_comment).permit(:user_id, :body)
    end

end
