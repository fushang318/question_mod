class AnswerCommentsController < ApplicationController
  before_action :find_answer
  before_action :find_question
  def index

  end

  def new
    comment = @answer.comments.new
  end

  def create
    comment = @answer.comments.create(answer_comment_params)
    comment.creator = current_user
    if comment.save
      html = render_to_string :partial => "/question_mod/question_comments/comment_li", :locals => {:comment => comment}
      return render :text => html
    end
    render :status => 500
  end

  def destroy
    comment = QuestionMod::Comment.find(params[:id])
    comment.destroy
    if comment.destroy
      html = render_to_string :partial => "/question_mod/question_comments/comment_li", :locals => {:comment => comment}
      return render :text => html
    end
    render :status => 500
  end

  private

    def answer_comment_params
      params.require(:comment).permit(:content, :reply_comment_id)
    end

    def find_answer
      @answer = Answer.find(params[:answer_id])
    end

    def find_question
      @question = QuestionMod::Question.find(params[:question_id])
    end
end
