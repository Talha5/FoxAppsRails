class AddNameSlugToStatuteType < ActiveRecord::Migration
  def change
    add_column :statute_types, :name_slug, :string
  end
end
