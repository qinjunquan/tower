class RenamColumnToEvents < ActiveRecord::Migration
  def change
    rename_column :events, :sub_resource, :sub_resource_type
  end
end
