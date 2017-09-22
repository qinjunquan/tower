class AddColumnsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :category_id, :integer
    add_column :events, :category_type, :string
    add_column :events, :sub_resource_id, :integer
    add_column :events, :sub_resource, :string
    add_column :events, :action, :integer, :default => 0
    add_column :events, :resource_changes, :text
    remove_column :events, :resource_content
    remove_column :events, :resource_title
    remove_column :events, :kind
  end
end
