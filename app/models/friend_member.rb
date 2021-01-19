class FriendMember < ApplicationRecord
  self.table_name = "friends_members"

  scope :friend, ->(friend_id) { where friend_id: friend_id }
  scope :member, ->(friend_id) { where member_id: friend_id }

  scope :friends, ->(friend_id) { friend(friend_id).or(member(friend_id)) }

  class << self
    #
    # @param [Object] member_id
    # @param [Object] friend_id
    #
    def add_friend member_id:, friend_id:
      unless existing_friends?(member_id: member_id, friend_id: friend_id)
        friend_member = FriendMember.new
        friend_member.member_id = member_id
        friend_member.friend_id = friend_id
        friend_member.save!
        friend_member
      end
    end

    #
    # @param [Object] member_id
    # @param [Object] friend_id
    #
    def existing_friends? member_id:, friend_id:
      FriendMember.where(member_id: member_id, friend_id: friend_id).
        or(FriendMember.where(member_id: friend_id, friend_id: member_id)).length > 0
    end

    #
    # @param [Object] member_id
    # @param [Object] friend_id
    #
    def fetch_friends member_id:
      friends(member_id)
    end
  end
end
