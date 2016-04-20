class Answer
  constructor: (@$answer)->
    @question_id = jQuery(".page-question-show .question .comment-content .form").data("question-id")
    
    @bind_event()

  backgroundColor_move: ->
    jQuery(event.target).closest(".answer").find(".update-form textarea").animate({backgroundColor:"red"},200)
    jQuery(event.target).closest(".answer").find(".update-form textarea").animate({backgroundColor:"white"},200)
    jQuery(event.target).closest(".answer").find(".update-form textarea").animate({backgroundColor:"red"},200)
    jQuery(event.target).closest(".answer").find(".update-form textarea").animate({backgroundColor:"white"},200)
    jQuery(event.target).closest(".answer").find(".update-form textarea").animate({backgroundColor:"red"},200)
    jQuery(event.target).closest(".answer").find(".update-form textarea").animate({backgroundColor:"white"},200)
    jQuery(event.target).closest(".answer").find(".update-form textarea").animate({backgroundColor:"red"},200)
    jQuery(event.target).closest(".answer").find(".update-form textarea").animate({backgroundColor:"white"},200)

  answer_update_form_toggleClass_hidden: ->
    jQuery(event.target).closest(".answer").find(".edit").toggleClass "hidden"
    jQuery(event.target).closest(".answer").find(".content").toggleClass "hidden"
    jQuery(event.target).closest(".answer").find(".update-form").toggleClass "hidden"


  bind_event: =>
    @$answer.on "click", ".edit", =>
      @answer_update_form_toggleClass_hidden()

    @$answer.on "click", ".update-form .update-cancel", =>
      @answer_update_form_toggleClass_hidden()

    @$answer.on "click", ".update-form .update-answer", =>
      @answer_id = jQuery(event.target).closest(".answer").find(".update-form").data("answer-id")
      content = jQuery(event.target).closest(".answer").find(".update-form textarea").val()
      content = jQuery.trim(content)
      $content = jQuery(event.target).closest(".answer").find(".content")
      $eidt = jQuery(event.target).closest(".answer").find(".edit")
      $update_form = jQuery(event.target).closest(".answer").find(".update-form")
      if content == ""
        @backgroundColor_move()
        return

      jQuery.ajax
        method: "PATCH"
        url: "/questions/#{@question_id}/answers/#{@answer_id}"
        data:
          "answer[content]": content
        type: "html"
        success: (html)=>
          $content.text(content)
          $content.toggleClass "hidden"
          $eidt.toggleClass "hidden"
          $update_form.toggleClass "hidden"
          

jQuery(document).on "page:change",->
  $answer = jQuery(".page-question-show .answer")

  if $answer.length > 0
    new Answer $answer
