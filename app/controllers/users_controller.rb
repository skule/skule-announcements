class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to root_url, :notice => "Signed up!"
    else
      render "new"
    end
  end

  def index
    @admin_users = User.all_admins
    @standard_users = User.all_standard

    respond_to do |format|
      format.html # index.html.erb
    end

  end
end
