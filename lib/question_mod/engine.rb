module QuestionMod
  class Engine < ::Rails::Engine
    isolate_namespace QuestionMod
    config.to_prepare do
      ApplicationController.helper ::ApplicationHelper

      Dir.glob(Rails.root + "app/decorators/question_mod/**/*_decorator.rb").each do |c|
        require_dependency(c)
      end

      User.class_eval do
        has_many :created_questions, class_name: 'QuestionMod::Question'
        has_many :answers, class_name: 'QuestionMod::Answer'

        def answered_questions
          question_ids = self.answers.map do |answer|
            answer.question_id
          end.compact.uniq

          QuestionMod::Question.where(:_id.in => question_ids)
        end
      end
    end
  end
end
