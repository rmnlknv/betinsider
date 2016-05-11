class UsersController < ApplicationController
  include ApplicationHelper
  before_action :user_signed_in?
  before_action :check_if_admin, only: [:index, :panel, :show, :addmoney]


  def index
    @users = User.all
  end

  def show
    @user = User.find_by_id(params[:id])
  end

  def panel
  end

  def addmoney
    user = User.find_by_id(params[:id])
    user.balance += params[:amount].to_f
    user.save
    redirect_to user
  end

  def profile
  end

end
