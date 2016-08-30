App.Components ||= {}

class App.Components.SearchAuthors
  @perform: (query) ->
    $.get("/authors/search", query: query).done((data) ->
      $(document).trigger("app:search_authors:done", [data.users])
    ).fail ->
      console.error "Search error."

