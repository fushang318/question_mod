class AnswerVote
  constructor: (@$elm)->
    @question_id = jQuery(".page-question-show .question .vote").data "question-id"
    @bind_event()

  bind_event: ->
    @$elm.on "click", "a.vote-up", (evt)=>
      @to_vote("vote_up")

    @$elm.on "click", "a.vote-down", (evt)=>
      @to_vote("vote_down")

  to_vote: (vote_type)->
    @answer_id = jQuery(event.target).closest(".vote").data "answer-id"
    $up_btn = jQuery(event.target).closest(".vote").find "a.vote-up"
    $down_btn = jQuery(event.target).closest(".vote").find "a.vote-down"
    $vote_sum = jQuery(event.target).closest(".vote").find ".vote-sum"
    jQuery.ajax
      method: "PUT"
      url: "/questions/#{@question_id}/answers/#{@answer_id}/"+ vote_type 
      type: "json"
      success: (info)=>
        @change_by_info(info,$up_btn,$down_btn,$vote_sum)

  change_by_info: (info,$up_btn,$down_btn,$vote_sum)->
    if info.state == "up"
      $up_btn.addClass "pressed"
      $down_btn.removeClass "pressed"

    if info.state == "down"
      $up_btn.removeClass "pressed"
      $down_btn.addClass "pressed"

    if info.state == null
      $up_btn.removeClass "pressed"
      $down_btn.removeClass "pressed"

    $vote_sum.text(info.vote_sum)


jQuery(document).on 'page:change', ->
  if jQuery(".page-question-show .answer .vote").length > 0
    new AnswerVote(jQuery(".page-question-show .answer .vote"))