class AddHeadlines < ActiveRecord::Migration[8.0]
  def change
    create_table :headlines, id: false do |t|
      t.bigserial :uid, primary_key: true
      t.string :title, null: false
      t.string :url, null: false
      t.string :source, null: false
      t.datetime :published_at, null: false
      t.jsonb :metadata, default: {}, null: false

      t.timestamps
    end

    add_index :headlines, :url, unique: true
  end
end
