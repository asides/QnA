$ ->
  $(document).on "click", ".add-comment-link", (e) ->
    e.preventDefault();
    $(this).hide();
    parent_id = $(this).data('parentId')
    $('form#new-comment-to-' + parent_id).show()
