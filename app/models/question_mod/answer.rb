module QuestionMod
  class Answer
    include Mongoid::Document
    include Mongoid::Timestamps
    include QuestionMod::VoteableMethod

    # content 不能为空
    field :content, :type => String

    validates :content, :presence => true
    validates :creator, :presence => true
    validates :question, :presence => true
    validate :question_creator_can_not_create_answer

    after_create :answer_created

    # 统计 所有 AnswerVote 的值总和
    # up +1
    # down -1
    field :vote_sum, :type => Integer, :default => 0

    # creator 不能为空
    belongs_to :creator,    :class_name => 'User'

    # question 不能为空
    belongs_to :question,       :class_name => 'QuestionMod::Question'
    has_many   :votes,   :class_name => 'QuestionMod::Vote', :as => :voteable
    has_many   :comments,:class_name => 'QuestionMod::Comment', :as => :targetable

    def question_creator_can_not_create_answer
      if self.creator == self.question.creator
        errors.add(:base,"用户不能给自己的 question 增加 answer")
      end
    end

    private
      def answer_created
        if self.question.answered == false
          self.question.update(:answered => true)
        end

        user = self.question.creator
      end
  end
end
