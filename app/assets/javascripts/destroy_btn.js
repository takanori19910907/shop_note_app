
$(function(){
  $('.checkbox-select').click(function() {
  if ($(".checkbox-select:checked").length > 0) {
      $('.destroy').show();
  } else {
  $('.destroy').hide();
    }
  });
});
