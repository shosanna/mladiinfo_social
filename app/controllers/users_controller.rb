# coding: utf-8
class UsersController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
      if @user.save
      sign_in @user
      flash[:success] = "Účet úspěšně vytvořen"
      redirect_to @user
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profil upraven"
      redirect_to @user
    else
      render 'edit'
    end
  end

  private
    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end

    def signed_in_user
      redirect_to signin_url unless signed_in?
      flash[:notice] = "Prosím přihlaš se" unless signed_in?
    end
end
