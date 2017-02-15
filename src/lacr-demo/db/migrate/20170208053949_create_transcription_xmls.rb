class CreateTranscriptionXmls < ActiveRecord::Migration[5.0]
  def change
    create_table :transcription_xmls do |t|
      t.jsonb :xml

      t.timestamps
    end
  end
end
