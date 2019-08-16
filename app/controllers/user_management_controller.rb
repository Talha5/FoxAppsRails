class UserManagementController < ApplicationController
  def index
    @users = User.all
  end
 
  def new
    @user = User.new
    @roles = Role.all
    @form_action = "create"
  end
  
  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
    @roles = Role.all
    @form_action = "update"
    respond_to do |format|
      format.js #edit.js.erb
    end
  end
  
  def create
    @user = User.create(params[:user])

    respond_to do |format|
      if @user.save
         @role = Role.where(:name => 'admin').first
         @ur = UserRole.create(:user_id => @user.id, :role_id => @role.id)
         @ur.save
         format.html { redirect_to user_management_index_url, notice: "User Created Successfully" }
        format.js { flash[:notice] = "User Created Successfully" }
      else
        format.html { render action: "new" }
        format.js { flash[:alert] = "Error Creating User <br /> #{@user.errors.messages}" }
      end
    end
  end

  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.js { flash[:notice] = "Updated User Successfully" }
      else
        format.js { flash[:alert] = "Error Updating User <br /> #{@user.errors.messages}" }
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    @users = User.all
    respond_to do |format|
      format.html { redirect_to user_management_index_url, notice: "User Deleted Successfully" }
      format.js { flash[:notice] = "Deleted User Successfully" }
    end
  end
end
