class QuestionsController < ApplicationController
  def index
    @questions = QuestionMod::Question.all
  end

  def new
    @question = QuestionMod::Question.new
  end

  def create
    @question = QuestionMod::Question.new(question_params)
    @question.creator = current_user
    if @question.save
      redirect_to questions_path
    else
      render :new
    end
  end

  def show
    @question = QuestionMod::Question.find(params[:id])
  end

  def vote_up
    @question = QuestionMod::Question.find(params[:id])
    @question.vote_up_by(current_user)
    @question.reload
    render :json => {
      :state    => @question.vote_state_of(current_user),
      :vote_sum => @question.vote_sum
    }
  end

  def vote_down
    @question = QuestionMod::Question.find(params[:id])
    @question.vote_down_by(current_user)
    @question.reload
    render :json => {
      :state    => @question.vote_state_of(current_user),
      :vote_sum => @question.vote_sum
    }
  end

  private
    def question_params
      params.require(:question).permit(:title, :content)
    end

end
