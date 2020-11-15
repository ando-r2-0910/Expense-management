class AddColumnToBookRecord < ActiveRecord::Migration[5.2]
  def change
    add_column :book_records, :comment, :text
  end
end
