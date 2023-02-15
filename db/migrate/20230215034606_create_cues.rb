class CreateCues < ActiveRecord::Migration[6.0]
  def change
    create_table :cues do |t|
      t.string :name
      t.text :path
      t.timestamps
    end
  end
end
