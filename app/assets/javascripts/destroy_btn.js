  $(document).on('click', '.checkbox-select', function(){

  if ($(".checkbox-select:checked").length > 0) {

      $('.destroy').show();
  } else {
  $('.destroy').hide();
    }
  });
