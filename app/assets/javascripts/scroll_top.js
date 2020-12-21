
  $(function(){
    $(window).scroll(function() {
      if ($(this).scrollTop() > 200) {
        $(".page_top").fadeIn();
      } else {
        $(".page_top").fadeOut();
      }
    });
    $(".page_top").click(function() {
      $("body,html").animate({
        scrollTop: 0
      }, 500);
      return false;
    });
  });
