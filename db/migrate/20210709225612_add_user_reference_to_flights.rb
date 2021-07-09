class AddUserReferenceToFlights < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key :flights, :users
    add_index :flights, :user_id
    change_column_null :flights, :user_id, false
  end
end
