class CreateTranscriptionXml < ActiveRecord::Migration[5.0]
  def change
    create_table :transcription_xmls do |t|
      t.json :xml
      t.integer :page_image_id
      t.timestamps
    end

  end
end
