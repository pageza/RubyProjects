class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  def new
      # render login page
  end
  def create
      # Log User In
      # if authenticate true
          # save user id to session
          # redirect to users profile page
      # if authenticate false
          # add an error message -> flash[:errors] = ["Invalid"]
          # redirect to login page
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to "/bright_ideas"
    else
      flash[:errors] = ["Invalid Combination"]
      redirect_to "/users/new"
    end
  end
  def destroy
      # Log User out
      reset_session
      redirect_to "/users/new"
  end
end
