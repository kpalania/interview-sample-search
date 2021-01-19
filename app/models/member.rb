class Member < ApplicationRecord
  validates_uniqueness_of :name
  scope :by_name, ->(member_name) { find_by_name(member_name.downcase) }
  serialize :headers, Array

  class << self
    #
    # @param [Object] params
    #
    def create_member params:
      @member = Member.new
      @member.name = params[:name].downcase
      @member.website = params[:website].downcase
      @member.shortening = ShortURL.shorten params[:website]
      @member.headers = get_headers website: params[:website]
      @member.save!
      @member
    end

    #
    # @param [Object] website
    #
    def get_headers website:
      doc = Nokogiri::HTML(open(website).read)
      h1 = doc.search('h1').map(&:text)
      h2 = doc.search('h2').map(&:text)
      h3 = doc.search('h3').map(&:text)
      [h1, h2, h3].flatten.uniq
    end

    #
    # @param [Object] token
    # @param [Object] member_name
    #
    def find_experts token:, member_name:
      #
      #
      #
      def all_experts experts:, token:
        experts = []
        Member.all.select do |x|
          experts << {
            member_name: x.name, header: x.headers.grep(/#{token}/).uniq
          }
        end
        experts
      end

      #
      #
      #
      def qualified_experts
        qualified_experts = []
        experts.each do |expert|
          unless expert[:header].empty?
            _expert = Member.by_name expert[:member_name]
            next if FriendMember.existing_friends?(member_id: @member.id, friend_id: _expert.id)
            qualified_experts << expert
          end
        end
        qualified_experts
      end

      all_experts experts: experts, token: token
      @member = Member.by_name member_name
      qualified_experts
    end
  end

  #
  # @param [Object] friend_name
  #
  def add_friend friend_name:
    Rails.logger.debug "....add friend: #{friend_name} to #{self.name}"
    @friend = Member.find_by_name(friend_name.downcase)
    FriendMember.add_friend member_id: self.id, friend_id: @friend.id
  end

  #
  #
  #
  def friends
    friends = FriendMember.fetch_friends member_id: self.id
    just_friends = ((friends.map(&:friend_id) + friends.map(&:member_id)) - [self.id]).uniq
    {
      friends_count: friends.count,
      friends_websites: Member.where(id: [just_friends]).map(&:website)
    }
  end
end
