class SessionsController < ApplicationController
  def create
    user = User.find_by_credentials(
      params[:user][:username], params[:user][:password]
    )
    if user
      login!(user)
      redirect_to root_url
    else
      flash.now[:errors] = ["Invalid username/password combination"]
      render :new
    end
  end

  def new
  end

  def destroy
    logout!
    redirect_to root_url
  end

end
