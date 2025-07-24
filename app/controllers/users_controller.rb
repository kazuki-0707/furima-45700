class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :nickname, :email, :encrypted_password, :last_name, :first_name,
      :last_name_kana, :first_name_kana, :birth_date
    )
  end
end