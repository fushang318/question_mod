module QuestionMod
  class Comment
    include Mongoid::Document
    include Mongoid::Timestamps

    field :content, :type => String

    after_create :comment_created

    validates :content, :presence => true
    validates :creator, :presence => true

    belongs_to :creator,  :class_name => 'User'
    belongs_to :targetable, :polymorphic => true

    belongs_to :reply_comment, :class_name => "QuestionMod::Comment"

    private
      def comment_created
        if self.targetable_type == "QuestionMod::Question"
          if self.reply_comment == nil
            user = self.targetable.creator
          else
            user = self.reply_comment.creator
          end
        end

        if self.targetable_type == "QuestionMod::Answer"
          if self.reply_comment.blank?
            user = self.targetable.creator
          else
            user = self.reply_comment.creator
          end
        end
      end
  end
end
