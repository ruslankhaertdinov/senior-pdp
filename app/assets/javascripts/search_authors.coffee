App.Components ||= {}

class App.Components.SearchAuthors
  constructor: (@$input) ->
    @_bindEvents()

  _bindEvents: ->
    @$input.on "typeahead:select", @_searchSelection
    @$input.on "typeahead:autocomplete", @_searchAutocomplete
    @$input.on "input", @_performBlankSearch

  _searchSelection: (event, suggestion) =>
    @_search(suggestion.title)

  _searchAutocomplete: (event, suggestion) =>
    @_search(suggestion.title)
    @$input.typeahead("close")

  _performBlankSearch: (event) =>
    if !event.target.value.length
      @_search("")

  _search: (query) ->
    $.get("/users/search", query: query).done((data) ->
      $(document).trigger("app:search_authors:done", [data.users])
    ).fail ->
      console.error "Search error."
