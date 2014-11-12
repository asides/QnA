# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  citynames = new Bloodhound(
    datumTokenizer: Bloodhound.tokenizers.obj.whitespace("name")
    queryTokenizer: Bloodhound.tokenizers.whitespace
    prefetch:
      url: "/tags.json"
      filter: (list) ->
        $.map list, (name) ->
          name: name

  )
  citynames.initialize()
  $("#question_tag_list").tagsinput
    typeaheadjs:
      name: "citynames"
      displayKey: "name"
      valueKey: "name"
      source: citynames.ttAdapter()
  # tag_list = new Bloodhound(
  #   datumTokenizer: Bloodhound.tokenizers.obj.whitespace("name")
  #   queryTokenizer: Bloodhound.tokenizers.whitespace
  #   prefetch:
  #     url: "/tags/index.json"
  #     filter: (list) ->
  #       log 'Its prefetch action!'
  #       log list
  #       $.map list, (name) ->
  #         name: name
  # )

  # tag_list.initialize()
  # log 'run'
  # $("#question_tag_list").typeahead null,
  #   name: "tags"
  #   displayKey: "name"
  #   source: tag_list.ttAdapter()


  # $("#question_tag_list").tagsinput typeaheadjs:
  #   name: "tags"
  #   displayKey: "name"
  #   valueKey: "name"
  #   source: tags.ttAdapter()
#   format = (item) ->
#     item.name

#   $("#question_tag_list").select2
#     tags: true
#     width: "100%"
#     tokenSeparators: [
#       ","
#       " "
#     ]
#     createSearchChoice: (term, data) ->
#       if $(data).filter(->
#         this.name.localeCompare(term) is 0
#       ).length is 0
#         id: term
#         text: term

#     multiple: true
#     maximumSelectionSize: 5
#     formatSelectionTooBig: (limit) ->
#       "You can only add 5 topics"

#     ajax:
#       dataType: "json"
#       url: "/tags/index.json"
#       data: (term, page) ->
#         q: term

#       results: (data, page) ->
#         results: data
#     formatSelection: format
#     formatResult: format
