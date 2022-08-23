class CreateExpiryTokens < ActiveRecord::Migration[7.0]
  def change
    create_table :expiry_tokens do |t|
      t.string :exp_token
      t.timestamps
    end
  end
end
