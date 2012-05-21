class AnnouncementsController < ApplicationController

  before_filter :verify_is_user, :only => [:new, :create]
  before_filter :verify_is_admin, :only => [:approve, :reject]
  before_filter :verify_is_owner, :only => [:edit, :update, :destroy]

  # GET /announcements
  # GET /announcements.xml
  def index
    @pending_announcements = []
    if admin_logged_in?
      @pending_announcements = Announcement.all_pending
    elsif current_user
      @pending_announcements = Announcement.all_current_user(current_user.id)
    end

    @current_approved_announcements = Announcement.all_current_approved
    @all_announcements = @current_approved_announcements + @pending_announcements

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @announcements }
    end
  end

  # GET /announcements/1
  # GET /announcements/1.xml
  def show
    @announcement = Announcement.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @announcement }
    end
  end

  # GET /announcements/new
  # GET /announcements/new.xml
  def new
    @announcement = Announcement.new
    
    if(current_user != nil)
      @announcement.contact = current_user.full_name
      @announcement.email = current_user.email
    end

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @announcement }
    end
  end

  # GET /announcements/1/edit
  def edit
    @announcement = Announcement.find(params[:id])
    @announcement.tag_string = @announcement.get_tag_string
  end

  # POST /announcements
  # POST /announcements.xml
  def create
    @announcement = Announcement.new(params[:announcement])
    @announcement.user = current_user

    respond_to do |format|
      if @announcement.save
        format.html { redirect_to(@announcement, :notice => 'Announcement was successfully created.') }
        format.xml  { render :xml => @announcement, :status => :created, :location => @announcement }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @announcement.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /announcements/1
  # PUT /announcements/1.xml
  def update
    @announcement = Announcement.find(params[:id])
    @announcement.is_approved = false  # updated announcement requires approval

    respond_to do |format|
      if @announcement.update_attributes(params[:announcement])
        format.html { redirect_to(@announcement, :notice => 'Announcement was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @announcement.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /announcements/1
  # DELETE /announcements/1.xml
  def destroy
    @announcement = Announcement.find(params[:id])
    @announcement.destroy

    respond_to do |format|
      format.html { redirect_to(announcements_url) }
      format.xml  { head :ok }
    end
  end

  # GET /announcements/1/approve
  def approve
    set_is_approved(true)
  end

  # GET /announcements/1/reject
  def reject
    set_is_approved(false)
  end


  private

  def set_is_approved(is_approved)
    announcement = Announcement.find(params[:id])
    announcement.is_approved = is_approved

    respond_to do |format|
      if announcement.save
        format.html { redirect_to(announcements_url) }
        format.xml  { head:ok }        
      else
        format.html { redirect_to(announcements_url, :notice => 'Edit was not successfull.') }
        format.xml  { render :xml => announcement.errors, :status => :unprocessable_entity }
      end
    end
  end

  # returns true if the current resource requested by the user is owned by that user or if that user is an admin
  # otherwise, the user is redirected to the root page.
  def verify_is_owner
    (current_user != nil && (admin_logged_in? || ((a = Announcement.find(params[:id])) != nil && a.user == current_user))) ? true : redirect_to(root_path)
  end

end
