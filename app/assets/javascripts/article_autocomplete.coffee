App.Components ||= {}

class App.Components.ArticleAutocomplete
  constructor: (@$el) ->
    @_initAutocomplete()

  _initAutocomplete: ->
    articles = new Bloodhound(
      datumTokenizer: Bloodhound.tokenizers.obj.whitespace("title")
      queryTokenizer: Bloodhound.tokenizers.whitespace
      prefetch:
        url: "/articles.json"
        cache: false
        transform: (response) ->
          response.articles
    )

    articles.initialize()

    @$el.typeahead null,
      display: "title"
      source: articles.ttAdapter()

$(document).ready ->
  articleAutocomplete = new App.Components.ArticleAutocomplete(document.getElementById("query"))