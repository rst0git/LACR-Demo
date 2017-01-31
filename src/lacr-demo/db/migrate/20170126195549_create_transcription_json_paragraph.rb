class CreateTranscriptionJsonParagraph < ActiveRecord::Migration[5.0]
  def change
    create_table :transcription_json_paragraphs do |t|
      t.jsonb :content
      t.string :title
      t.string :language
      t.string :date
      t.integer :transcription_xml_id
      t.integer :search_id
      t.timestamps
    end
  end
end
