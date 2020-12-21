
$(function() {
$("input[type=file]").change(function () {
  let file = $(this).prop("files")[0];
  $(".js-upload-filename").text(file.name + "を選択中");
  $(".js-upload-filename").after("<i class=\"fa fa-times-circle btn\"</i>");
  $(".fa-image").attr("id", "set_image");
});

$("ul").on("click",".fa-times-circle",function () {
  $(".js-upload-file").val("");
  $(".js-upload-filename").text("");
  $(this).hide();
  $(".fa-image").removeAttr("id");
  });
});
