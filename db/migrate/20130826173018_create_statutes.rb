class CreateStatutes < ActiveRecord::Migration
  def change
    create_table :statutes do |t|
      t.string :name

      t.timestamps
    end
  end
end
