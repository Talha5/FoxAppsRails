class CreateStatuteTypes < ActiveRecord::Migration
  def change
    create_table :statute_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
