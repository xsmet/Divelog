class AddSignupmailToUser < ActiveRecord::Migration
  def change
    add_column :users, :email_original, :string
    add_column :users, :date_of_birth, :date
  end
end
