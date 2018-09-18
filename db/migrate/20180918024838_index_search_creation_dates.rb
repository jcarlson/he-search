class IndexSearchCreationDates < ActiveRecord::Migration[5.2]
  def change
    add_index :searches, :created_at, order: { created_at: :desc }
  end
end
