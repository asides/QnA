# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  tags = new Bloodhound(
    datumTokenizer: Bloodhound.tokenizers.obj.whitespace("name")
    queryTokenizer: Bloodhound.tokenizers.whitespace
    remote:
      url: "/tags/autocomplete?query=%QUERY"
      filter: (list) ->
        $.map list, (name) ->
          name: name
  )

  tags.initialize()

  $("#question_tag_list").tagsinput
    typeaheadjs:
      name: "tags"
      displayKey: "name"
      valueKey: "name"
      source: tags.ttAdapter()
