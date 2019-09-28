class AlterGramsAddUserId < ActiveRecord::Migration[6.0]
  def change
    add_column :grams, :user_id, :integer
    add_index :grams, :user_id
  end
end
