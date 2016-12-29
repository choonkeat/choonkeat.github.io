(function($) {
  $(function() {
    $('.pullquote').each(function(index, span) {
      var $span = $(span),
          $quote = $span.clone().addClass('pulled-quote'),
          $para = $span.parents('p').before($quote);
    });
  });
})(jQuery.noConflict());
