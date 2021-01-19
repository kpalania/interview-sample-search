class CreateJoinTableMemberFriends < ActiveRecord::Migration[6.0]
  def change
    create_join_table :members, :friends do |t|
      t.index [:member_id, :friend_id]
    end
  end
end
