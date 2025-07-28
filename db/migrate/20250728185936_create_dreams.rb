class CreateDreams < ActiveRecord::Migration[7.2]
  def change
    create_table :dreams do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.text :description
      t.string :emotion
      t.date :dream_date
      t.string :tags
      t.text :ai_summary
      t.boolean :analyzed

      t.timestamps
    end
  end
end
