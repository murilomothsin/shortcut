class CreateShortcuts < ActiveRecord::Migration[7.1]
  def change
    create_table :shortcuts do |t|
      t.string :short_url, index: { unique: true }
      t.string :full_url
      t.string :title
      t.integer :click_count

      t.timestamps
    end
  end
end
