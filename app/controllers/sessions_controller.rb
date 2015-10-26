class SessionsController < ApplicationController
  def new

  end

  def create
    @user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password]
    )

    if @user
      sign_in!(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = "Invalid Credentials"
      render :new, status: :bad_request
    end
  end

  def destroy

  end
end
