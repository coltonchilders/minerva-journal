class AddEditedFieldToJournalEntry < ActiveRecord::Migration[6.0]
  def change
    add_column :journal_entries, :edited, :boolean
  end
end
