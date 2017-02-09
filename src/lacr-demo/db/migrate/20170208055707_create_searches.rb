class CreateSearches < ActiveRecord::Migration[5.0]
  def change
    create_table :searches do |t|
      t.integer :tr_paragraph_id

      t.string :entry
      t.string :entry_type
      t.string :lang

      t.integer :volume
      t.integer :page
      t.integer :paragraph

      t.text :content

      t.date :date

      t.timestamps
    end
    add_foreign_key :searches, :tr_paragraphs, on_delete: :cascade
    add_foreign_key :tr_paragraphs, :searches, on_delete: :cascade
  end
end
