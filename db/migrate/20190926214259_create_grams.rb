class CreateGrams < ActiveRecord::Migration[6.0]
  def change
    create_table :grams do |t|
      t.text :message
      t.timestamps
    end
  end
end
