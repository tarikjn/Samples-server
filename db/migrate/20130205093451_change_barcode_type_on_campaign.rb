class ChangeBarcodeTypeOnCampaign < ActiveRecord::Migration
  def up
    change_column :campaigns, :barcode, :string
  end

  def down
    change_column :campaigns, :barcode, :integer
  end
end
