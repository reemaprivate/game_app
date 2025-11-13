class AddIndexOnEmailForEmployees < ActiveRecord::Migration[8.0]
  def change
    add_index :employees, :email
  end
end
