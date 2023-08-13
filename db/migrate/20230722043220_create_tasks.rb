class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    unless table_exists?(:tasks)
      create_table :tasks do |t|
        t.string :name
        t.text :description

        # t.timestamps
        t.datetime :created_at, precision: 6
        t.datetime :updated_at, precision: 6
      end
    end
  end
end
