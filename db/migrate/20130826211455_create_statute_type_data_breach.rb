class CreateStatuteTypeDataBreach < ActiveRecord::Migration
  def up
  	StatuteType.create(:name => 'Data Breach', :name_slug => 'data-breach')
  end

  def down
  end
end
