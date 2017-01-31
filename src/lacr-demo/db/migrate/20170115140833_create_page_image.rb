class CreatePageImage < ActiveRecord::Migration[5.0]
  def change
    create_table :page_images do |t|
      t.integer :transcription_xml_id
      t.integer :transcription_json_paragraph_id
      t.json :image
      t.timestamps
    end
  end
end
