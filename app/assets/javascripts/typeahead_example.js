// TODO: remove cache: false after debugging

var articles = new Bloodhound({
  datumTokenizer: Bloodhound.tokenizers.obj.whitespace("title"),
  queryTokenizer: Bloodhound.tokenizers.whitespace,
  prefetch: {
    url: "/articles.json",
    cache: false,
    transform: function(response) {
      return response.articles;
    }
  }
});

articles.initialize();

$("#query").typeahead(null, {
  display: "title",
  source: articles.ttAdapter()
});
