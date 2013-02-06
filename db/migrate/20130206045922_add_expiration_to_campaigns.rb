class AddExpirationToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :expiration, :datetime
    rename_column :campaigns, :brand_owner_id, :owner_id
  end
end
