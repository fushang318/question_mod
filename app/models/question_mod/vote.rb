module QuestionMod
  class Vote
    extend Enumerize
    KIND_UP   = 'up'
    KIND_DOWN = 'down'

    include Mongoid::Document
    include Mongoid::Timestamps


    # up down 二选一
    enumerize :kind, in: [:up, :down]
    validates :creator, :presence => true

    after_create :vote_created
    before_update :update_vote
    before_destroy :destroy_vote

    # creator 不能为空
    belongs_to :creator, :class_name => 'User'
    belongs_to :voteable, :polymorphic => true

    private
      def change_vote_sum(change_count)
        self.voteable.set(:vote_sum => self.voteable.vote_sum + change_count)
      end

      def vote_created
        user = self.voteable.creator

        if self.kind == KIND_UP
          change_vote_sum 1
        elsif self.kind == KIND_DOWN
          change_vote_sum -1
        end 
      end

      def update_vote
        kinds = self.changes["kind"]
        if kinds == [KIND_UP,KIND_DOWN]
          change_vote_sum -2
        elsif kinds == [KIND_DOWN,KIND_UP]
          change_vote_sum 2
        end
      end

      def destroy_vote
        if self.kind == KIND_UP
          change_vote_sum -1
        elsif self.kind == KIND_DOWN
          change_vote_sum 1
        end
      end
  end
end
