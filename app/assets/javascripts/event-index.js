app.eventIndex = {
  init : function() {
    if($("#js-event-index").get(0)){
      this.initStatus();
      this.bindingEvents();
    }
  },

  initStatus : function() {
    app.eventIndex.loadStatus = 0; //0:wait 1:loading 2:no more
  },

  bindingEvents : function() {
    var winH = $(window).height(); //页面可视区域高度
    $(window).scroll(function() {
      var pageH = $(document.body).height();
      var scrollT = $(window).scrollTop(); //滚动条top
      var aa = (pageH - winH - scrollT) / winH;
      if (aa < 0.02) {
        if(app.eventIndex.loadStatus == 0) {
          $("#js-loadmore-hint").show();
          var page = parseInt($("#js-loadmore").data("page"));
          if(page == 0) {
            page = 1;
          }
          app.eventIndex.loadStatus = 1;
          $.ajax({
            url : "/teams/" + $("#js-loadmore").data("tid") + "/events/loadmore",
            type : "GET",
            data : {
              "project_id" : $("#js-loadmore").data("pid"),
              "last_event_id" : $("#js-loadmore").data("lastid"),
              "page" : page + 1
            },
            success : function(html){
              if(html == "") {
                app.eventIndex.loadStatus = 2;
                $("#js-loadmore-hint").text("已经到底了哦!");
              } else {
                $("#js-loadmore").data("page", page + 1);
                $("#js-event-list").append(html);
                app.eventIndex.loadStatus = 0;
                $("#js-loadmore-hint").hide();
              }
            },
            error : function() {
              app.eventIndex.loadStatus = 0;
              $("#js-loadmore-hint").hide();
              alert("不好意思出错了，请重试");
            }
          });
        }
      }
    });
  }
}
