class CreateJournalEntries < ActiveRecord::Migration[6.0]
  def change
    create_table :journal_entries do |t|
      t.string :title
      t.text :body
      t.references :journal, index: true, foreign_key: true

      t.timestamps
    end
  end
end
