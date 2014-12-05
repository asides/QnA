$ ->
  $(document).on "click", ".add-comment-link", (e) ->
    e.preventDefault();
    $(this).hide();
    parent_id = $(this).data('parentId')
    $('#new-comment-to-' + parent_id).show()

  $(document).on "click", ".edit-comment-link", (e) ->
    e.preventDefault();
    $(this).hide();
    comment_id = $(this).data('commentId')
    $('#comment-'+comment_id+' .edit_comment').show()
