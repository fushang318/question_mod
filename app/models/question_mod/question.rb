module QuestionMod
  class Question
    include Mongoid::Document
    include Mongoid::Timestamps
    include QuestionMod::VoteableMethod
    include QuestionMod::Comment::CommentAbleMethods

    default_scope ->{ order(vote_sum: :desc) }
    scope :answered, -> { where(:answered => true)}
    scope :unanswered, -> { where(:answered => false)}

    # title content 不能为空
    field :title,   :type => String
    field :content, :type => String
    field :answered, :type => Boolean, :default => false

    validates :title, :presence => true
    validates :creator, :presence => true
    # creator 不能为空
    belongs_to :creator,         :class_name => 'User'

    has_many :answers, :class_name => 'QuestionMod::Answer', :order => :vote_sum.desc
  end
end
