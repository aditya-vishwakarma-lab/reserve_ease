class RegistrationsController < ApplicationController
  allow_unauthenticated_access only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.role = User.staff_email?(user_params[:email_address]) ? 'staff' : 'customer'
    if @user.save
      start_new_session_for(@user) # sign in the user after registration
      redirect_to root_path, notice: "Welcome to the app!"
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email_address, :password, :password_confirmation)
  end
end
