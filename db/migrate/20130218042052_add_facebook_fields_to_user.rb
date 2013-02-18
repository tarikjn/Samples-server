class AddFacebookFieldsToUser < ActiveRecord::Migration
  def up
    add_column :users, :birthday, :date
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :gender, :string
    add_column :users, :facebook_friends_count, :integer
    execute "
      ALTER TABLE users
        ALTER COLUMN facebook_id TYPE integer USING CAST(facebook_id AS integer)
    "
  end

  def down
    execute "
      ALTER TABLE users
        ALTER COLUMN facebook_id TYPE string USING CAST(facebook_id AS string)
    "
    remove_column :users, :facebook_friends_count, :gender, :last_name, :first_name, :birthday
  end
end
