class CreateDefaultUserAndRoles < ActiveRecord::Migration
  def up
  	@user = User.create(:email => 'support@sparknettech.com', :password => 'Spn16058!', :password_confirmation => 'Spn16058!')
    @role = Role.create(:name => 'admin')
    UserRole.create(:role_id => @role.id, :user_id => @user.id)
    Role.create(:name => 'databreach')
  end

  def down
  end
end
