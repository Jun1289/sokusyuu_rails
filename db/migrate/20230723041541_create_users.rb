class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    unless table_exists?(:users)
      create_table :users do |t|
        t.string :name, null: false
        t.string :email, null: false
        t.string :password_digest, null: false

        # t.timestamp
        t.datetime :created_at, precision: 6
        t.datetime :updated_at, precision: 6
        t.index :email, unique: true
      end
    end
  end
end
