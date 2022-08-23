class AddAuthTokenToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :auth_token, :string, unique: true
  end
end
