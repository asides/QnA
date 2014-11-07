# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $(document).on "click", ".edit-answer-link", (e) ->
    e.preventDefault();
    $(this).hide();
    answer_id = $(this).data('answerId')
    $('form#edit-answer-' + answer_id).show()

  # $('form.new_answer').bind 'ajax:success', (e, data, status, xhr) ->
  #   answer = $.parseJSON(xhr.responseText)
  #   $('.answers').append('<p>'+answer.body+'</p>')
  # .bind 'ajax:error', (e, xhr, status, error) ->
  #   errors = $.parseJSON(xhr.responseText)
  #   $.each errors, (index, value) ->
  #     $('#answer-errors').append(value)

  # questionId = $('.answers').data('questionId')
  # PrivatePub.subscribe '/questions/'+questionId+'/answers', (data, channel) ->
  #   answer = $.parseJSON(data['answer'])
  #   $('.answers').append('<p>'+answer.body+'</p>')
  #   $('.answers').append('<p><a href="#">Edit</a></p>')
  #   $('.new_answer #answer_body').val('');
