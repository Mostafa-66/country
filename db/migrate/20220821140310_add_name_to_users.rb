class AddNameToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :name, :string
    add_column :users, :phone, :string
    add_column :users, :gender, :string
    add_column :users, :completed, :boolean, default: false
  end
end
