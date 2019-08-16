class CreateTextEntries < ActiveRecord::Migration
  def change
    create_table :text_entries do |t|
      t.integer :statute_type_id
      t.integer :jurisdiction_id
      t.text :text_value

      t.timestamps
    end
  end
end
