class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url, :notice => "Congrats, you're signed up!"
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

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to root_url, :notice => 'User was successfully updated.' }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end

  # GET /users/1/promote
  def promote
    set_is_admin(true)
  end


  # GET /users/1/demote
  def demote
    set_is_admin(false)
  end

  def set_is_admin(is_admin)
    user = User.find(params[:id])
    user.is_admin = is_admin

    respond_to do |format|
      if user.save
        format.html { redirect_to(users_url) }
        format.xml  { head:ok }        
      else
        format.html { redirect_to(users_url, :notice => 'Edit was not successfull.') }
        format.xml  { render :xml => user.errors, :status => :unprocessable_entity }
      end
    end

  end


end
