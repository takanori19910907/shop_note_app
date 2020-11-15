$(function() {
  $("main").on('click', '.note_image',function() {
    $("#image_display").html($(this).prop('outerHTML'));
    $("#image_display").fadeIn(200);
    $('.destroy').addClass('none');
   });

  $("body").on('click', '#image_display',function () {
    $("#image_display").fadeOut(200);
  });
});
