class QuestionComment
  constructor: (@$show_comment, @$comment_content)->
    @question_id = @$comment_content.find(".form").data("question-id")
    @bind_event()

  backgroundColor_move: (textarea,coler1,color2,speed)->
    @$comment_content.find(textarea).animate({backgroundColor:color2},speed)
    @$comment_content.find(textarea).animate({backgroundColor:coler1},speed)
    @$comment_content.find(textarea).animate({backgroundColor:color2},speed)
    @$comment_content.find(textarea).animate({backgroundColor:coler1},speed)
    @$comment_content.find(textarea).animate({backgroundColor:color2},speed)
    @$comment_content.find(textarea).animate({backgroundColor:coler1},speed)
    @$comment_content.find(textarea).animate({backgroundColor:color2},speed)
    @$comment_content.find(textarea).animate({backgroundColor:coler1},speed)

  bind_event: ->
    @$show_comment.on "click", =>
      @$comment_content.toggleClass "hidden"

    @$comment_content.on "click", ".form a.btn.add-comments", =>

      content = @$comment_content.find(".form textarea").val()
      content = jQuery.trim(content)
      if content == ""
        @backgroundColor_move(".form textarea","white","red",200)
        return

      jQuery.ajax
        method: "POST"
        url: "/questions/#{@question_id}/comments"
        data:
          "comment[content]": content
        type: "html"
        success: (html)=>
          @$comment_content.find(".form textarea").val("")
          @$comment_content.find("ul.comments").append(html)

    @$comment_content.on "click", "ul.comments a.reply", =>
      jQuery(event.target).closest(".comment").find(".comment-form").toggleClass "hidden"

    @$comment_content.on "click", "ul.comments a.cancel", =>
      jQuery(event.target).closest(".comment").find(".comment-form").toggleClass "hidden"

    @$comment_content.on "click", "ul.comments a.add-comments", =>
      $comment_form = jQuery(event.target).closest(".comment-form")
      content = $comment_form.find("textarea").val()
      content = jQuery.trim(content)
      reply_comment_id = jQuery(event.target).closest(".comment-form").data("comment-id")
      if content == ""
        @backgroundColor_move(".comment .comment-form textarea","white","red",200)
        return

      jQuery.ajax
        method: "POST"
        url: "/questions/#{@question_id}/comments"
        data:
          "comment[content]": content,
          "comment[reply_comment_id]": reply_comment_id
        type: "html"
        success: (html)=>
          $comment_form.remove()
          @$comment_content.find("ul.comments").append(html)


    @$comment_content.on "click", "ul.comments a.delete", =>
      @comment_id = jQuery(event.target).closest(".comment").data("comment-id")
      $comment_content = jQuery(event.target).closest(".comment")
      jQuery.ajax
        method: "DELETE"
        url: "/questions/#{@question_id}/comments/#{@comment_id}"
        success: =>
          $comment_content.remove()


jQuery(document).on 'page:change', ->
  $show_comment = jQuery(".page-question-show .question .show-comment")
  $comment_content = jQuery(".page-question-show .question .comment-content")

  if $show_comment.length > 0 && $comment_content.length > 0
    new QuestionComment $show_comment, $comment_content
