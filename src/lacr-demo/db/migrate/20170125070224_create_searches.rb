class CreateSearches < ActiveRecord::Migration[5.0]
  def change
    create_table :searches do |t|
      t.string :title
      t.text :content
      t.string :doc_id
      t.timestamps
    end
    add_column :documents, :date, :string
    add_column :documents, :language, :string
  end
end
