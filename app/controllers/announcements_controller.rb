class AnnouncementsController < ApplicationController

  

  # GET /announcements
  # GET /announcements.xml
  def index
    @pending_announcements = []
    if admin_logged_in?
      @pending_announcements = Announcement.all_pending
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
end
