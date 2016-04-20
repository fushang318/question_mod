module QuestionMod
  class Vote
    extend Enumerize
    KIND_UP   = 'up'
    KIND_DOWN = 'down'

    include Mongoid::Document
    include Mongoid::Timestamps

    # up down 二选一
    enumerize :kind, in: [KIND_UP, KIND_DOWN]
    validates :creator, :presence => true

    # creator 不能为空
    belongs_to :creator, :class_name => 'User'
    belongs_to :voteable, :polymorphic => true

    private

      after_create :vote_created
      def vote_created
        if self.kind == KIND_UP
          self.voteable.inc(:vote_sum => 1)
        elsif self.kind == KIND_DOWN
          self.voteable.inc(:vote_sum => -1)
        end
      end

      before_update :update_vote
      def update_vote
        kinds = self.changes["kind"]

        if kinds == [KIND_UP,KIND_DOWN]
          self.voteable.inc(:vote_sum => -2)
        elsif kinds == [KIND_DOWN,KIND_UP]
          self.voteable.inc(:vote_sum => 2)
        end
      end

      before_destroy :destroy_vote
      def destroy_vote
        if self.kind == KIND_UP
          self.voteable.inc(:vote_sum => -1)
        elsif self.kind == KIND_DOWN
          self.voteable.inc(:vote_sum => 1)
        end
      end
  end
end
