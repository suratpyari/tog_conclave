class AddIconFieldToEvent < ActiveRecord::Migration
  def self.up
    add_column :events, :icon, :string
  end

  def self.down
    remove_column :events, :icon
  end
end
