class CreateFriends < ActiveRecord::Migration[6.0]
  def change
    create_table :friends do |t|
      t.string :source
      t.string :target

      t.timestamps
    end
  end
end
