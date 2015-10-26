class SessionsController < ApplicationController
  skip_before_action :ensure_signed_in, only: [:new, :create]

  def new

  end

  def create
    @user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password]
    )

    if @user
      sign_in!(@user)
    else
      flash.now[:errors] = "Invalid Credentials"
      render :new
    end
  end

  def destroy
    sign_out!
  end

end
