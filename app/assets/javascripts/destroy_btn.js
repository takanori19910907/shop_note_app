
$(function(){
  $(document).on('click', '.checkbox-select', function(){

  if ($(".checkbox-select:checked").length > 0) {
    console.log($(".checkbox-select:checked").length);
      $('.destroy').show();
  } else {
  $('.destroy').hide();
    }
  });
});
