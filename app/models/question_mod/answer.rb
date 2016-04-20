module QuestionMod
  class Answer
    include Mongoid::Document
    include Mongoid::Timestamps
    include QuestionMod::VoteableMethod
    include QuestionMod::Comment::CommentAbleMethods

    # content 不能为空
    field :content, :type => String

    validates :content, :presence => true
    validates :creator, :presence => true
    validates :question, :presence => true

    # creator 不能为空
    belongs_to :creator, :class_name => 'User'

    # question 不能为空
    belongs_to :question, :class_name => 'QuestionMod::Question'

    private
      validate :question_creator_can_not_create_answer
      def question_creator_can_not_create_answer
        if self.creator == self.question.creator
          errors.add(:base,"用户不能给自己的 question 增加 answer")
        end
      end

      after_create :answer_created
      def answer_created
        if self.question.answered == false
          self.question.update(:answered => true)
        end
      end
  end
end
