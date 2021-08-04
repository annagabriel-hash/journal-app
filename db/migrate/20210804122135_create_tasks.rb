class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.text :todo
      t.datetime :due
      t.text :notes
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
