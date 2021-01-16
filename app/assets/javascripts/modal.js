$(function() {
$(document).on("click",".js_count_btn",function() {
$("#count_id").val(this.value);
});
$(document).on("click",".js_comment_btn",function () {
$("#comment_id").val(this.value);
});
});
