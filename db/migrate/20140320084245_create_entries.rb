class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.integer :entry

      t.timestamps
    end
  end
end
