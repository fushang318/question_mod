class QuestionVote
  constructor: (@$ele)->
    @question_id = @$ele.data "question-id"
    @up_btn   = @$ele.find "a.vote-up"
    @down_btn = @$ele.find "a.vote-down"
    @$vote_sum = @$ele.find ".vote-sum"
    @bind_event()

  bind_event: ->
    @$ele.on "click", "a.vote-up", (evt)=>
      @to_vote("vote_up")

    @$ele.on "click", "a.vote-down", (evt)=>
      @to_vote("vote_down")

  to_vote: (vote_type)->
    jQuery.ajax
      method: "PUT"
      url: "/questions/#{@question_id}/" + vote_type
      success: (info)=>
        @change_by_info info

  change_by_info: (info)->
    if info.state == "up"
      @up_btn.addClass "pressed"
      @down_btn.removeClass "pressed"

    if info.state == "down"
      @up_btn.removeClass "pressed"
      @down_btn.addClass "pressed"

    if info.state == null
      @up_btn.removeClass "pressed"
      @down_btn.removeClass "pressed"

    @$vote_sum.text(info.vote_sum)


jQuery(document).on 'page:change', ->
  if jQuery(".page-question-show .question .vote").length > 0
    new QuestionVote(jQuery(".page-question-show .question .vote"))
