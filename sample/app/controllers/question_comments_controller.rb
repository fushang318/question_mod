class QuestionCommentsController < ApplicationController
  before_action :find_question
  def index
  end

  def new
    comment = @question.comments.new
  end

  def create
    comment = @question.comments.create(question_comment_params)
    comment.creator = current_user
    if comment.save
      html = render_to_string :partial => "/question_mod/question_comments/comment_li", :locals => {:comment => comment}
      return render :text => html
    end
    render :status => 500
  end

  def destroy
    comment = QuestionMod::Comment.find(params[:id])
    if comment.destroy
      html = render_to_string :partial => "/question_mod/question_comments/comment_li", :locals => {:comment => comment}
      return render :text => html
    end
    render :status => 500
  end

  private

    def question_comment_params
      params.require(:comment).permit(:content, :reply_comment_id)
    end

    def find_question
      @question = QuestionMod::Question.find(params[:question_id])
    end
end
