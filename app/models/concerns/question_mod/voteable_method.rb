module QuestionMod
  module VoteableMethod
    extend ActiveSupport::Concern

    included do
      # 统计 所有 AnswerVote 的值总和
      # up +1
      # down -1
      field :vote_sum, :type => Integer, :default => 0
      has_many :votes,   :class_name => 'QuestionMod::Vote', :as => :voteable
    end

   # 有三种起始状态
    # 1 用户没有任何对应 vote
    # 2 用户已经是 vote_up
    # 3 用户是 vote_down
    def vote_up_by(user)
      _vote_by(user, Vote::KIND_UP, Vote::KIND_DOWN)
    end

    # 有三种起始状态
    # 1 用户没有任何对应 vote
    # 2 用户已经是 vote_up
    # 3 用户是 vote_down
    def vote_down_by(user)
      _vote_by(user, Vote::KIND_DOWN, Vote::KIND_UP)
    end

    def _vote_by(user, add_kind, remove_kind)
      current_kind = vote_state_of(user)

      case current_kind
      when nil
        votes.create(:kind => add_kind, :creator => user)
      when add_kind
        votes.where(:creator => user).destroy_all
      when remove_kind
        vote = votes.where(:creator => user).first
        vote.update_attribute(:kind, add_kind)
      end
    end

    # 返回值是如下三个常量之一
    # AnswerVote::KIND_UP
    # AnswerVote::KIND_DOWN
    # nil
    def vote_state_of(user)
      votes.where(:creator => user).all.first.try(:kind)
    end

    def is_vote_up_of(user)
      vote_state_of(user) == Vote::KIND_UP
    end

    def is_vote_down_of(user)
      vote_state_of(user) == Vote::KIND_DOWN
    end
  end
end
