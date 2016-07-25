$(document).ready(function(){
  var timerId = null,
    $query = $("#query");

  $query.on("keyup", function(e){
    clearTimeout(timerId);
    timerId = setTimeout(search, 500);
  });

  function search() {
    $.get("/authors/search", { query: $query.val() });
  }
});
