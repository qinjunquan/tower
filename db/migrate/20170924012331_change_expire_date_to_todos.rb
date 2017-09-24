class ChangeExpireDateToTodos < ActiveRecord::Migration
  def change
    change_column :todos, :expire_date, :date
  end
end
