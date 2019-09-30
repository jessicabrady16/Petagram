class AddPictureToGrams < ActiveRecord::Migration[6.0]
  def change
    add_column :grams, :picture, :string
  end
end
