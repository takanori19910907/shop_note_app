$(function() {
  $('.js_count_btn').click(function() {
  $('#count_id').val(this.value);
  });
  $('.js_comment_btn').on('click', function () {
  $('#comment_id').val(this.value);
  });
});
