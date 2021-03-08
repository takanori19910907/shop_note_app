
$(function() {
$(".own_note").on("click", ".image_field",function() {
  $(".checkbox-select").prop('checked', false);
  $("#image_display").html($(this).prop("outerHTML"));
  $("#image_display").fadeIn(200);
  $(".destroy").addClass("none");
});

$("body").on("click", "#image_display",function () {
  $("#image_display").fadeOut(200);
  });
});
