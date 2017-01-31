class AddForignKeys < ActiveRecord::Migration[5.0]
  def change
    add_foreign_key :page_images, :transcription_xmls, on_delete: :cascade
    add_foreign_key :transcription_xmls, :page_images, on_delete: :cascade
    add_foreign_key :transcription_json_paragraphs, :transcription_xmls, on_delete: :cascade
    add_foreign_key :transcription_json_paragraphs, :searches, on_delete: :cascade
    add_foreign_key :page_images, :transcription_json_paragraphs, on_delete: :cascade
  end
end
