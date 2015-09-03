class UsersController < ApplicationController
  before_action :authenticate_member!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end
end
