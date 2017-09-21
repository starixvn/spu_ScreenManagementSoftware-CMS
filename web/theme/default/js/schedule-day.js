var day_schedule_counter = 0;

$.fn.getHeight = function(){
  return parseInt(this.css("height"));
}

function day_schedule() {
    var timeElems = $(".cal-day-hour-part");
    var times = timeElems.map((index, value) => $(value).text().trim()).get();
    var coordinates = timeElems.map((index, value) => $(value).position().top).get();
    var calendar = $("#cal-day-panel");

    createLastElem();

    day_schedule_counter++;

    function binarySearch(arr, target) {
        function binarySearchSub(arr, target, start, end) {
            if (end - start + 1 == 2) {
                return start;
            }
            else {
                var m = Math.floor((start + end) / 2);
                var vm = arr[m];

                return (target < vm) ? binarySearchSub(arr, target, start, m) : binarySearchSub(arr, target, m, end)
            }
        }

        return binarySearchSub(arr, target, 0, arr.length - 1);
    }

    function createLastElem(){
      coordinates.push(coordinates[coordinates.length - 1] + timeElems.getHeight());

      var $last = timeElems.eq(timeElems.length - 1);

      var date = new Date(parseInt($last.attr("time-data")));

      date.setMinutes(date.getMinutes() + 30);

      var div =
        "<div class='cal-day-hour-part' style='margin-top: {0}px; height: {1}px' time-data='{2}'><span class='cal-hours'></span></div>"
        .replace("{0}", $last.position().top + $last.getHeight())
        .replace("{1}", $last.getHeight())
        .replace("{2}", date.getTime());

      timeElems.push(div);
    }

    this.daySize = function (renderForm1, renderForm2) {
        var state = null;

        var isClick = true;
        var cancelClick = null;

        function detectClick(){
          isClick = false;
        }

        function initScaling(e) {
            cancelClick = setTimeout(detectClick, 200);
            var $this = $(this);

            var offset = e.offsetY;
            var y = e.pageY;
            var height = parseInt($this.css("height"));
            var margin_top = parseInt($this.css("margin-top"));

            var allowed = 10;

            if ((offset <= allowed || height - offset <= allowed) && e.which == 1) {
                state =
                {
                    height: height,
                    margin_top: margin_top,
                    y: y,
                    dir: (offset <= allowed) ? "up" : "down",
                    $target: $this,
                    $writeTarget: $this.find(".cal-hours"),
                    isTmp: false
                };
            }
        }

        function detectBorder(e){
            var offset = e.offsetY;
            var allowed = 10;
            var elm = $(e.target);

            if (elm.hasClass('day-event')) {
                var height = parseInt(elm.css("height"));
                if (offset <= allowed || height - offset <= allowed || state != null) {
                    if (!elm.hasClass('resize-event')) {
                        elm.addClass('resize-event');
                    }
                }
                else{
                    elm.removeClass('resize-event');
                }
            }
        }

        function detectStart(e) {
            $target = detectElem(e, true);

            cancelClick = setTimeout(detectClick, 200);

            if($target != null && e.which == 1){
              var div =
                "<div class='selected-hour' style='position:relative; margin-top: {0}px; height: {1}px'><span class='cal-hours'></span></div>"
                .replace("{0}", $target.position().top)
                .replace("{1}", $target.getHeight());

              var $div = $(div);

              state =
              {
                height : $target.getHeight(),
                margin_top : $target.position().top,
                y : e.pageY,
                $target : $div,
                $writeTarget: $div.find("span"),
                isTmp : true,
              }
            }
        }

        function moveUp(diff) {
            var c = state.margin_top + diff;
            var maxheight = calendar.getHeight();

            if(c + state.height >= maxheight) c = maxheight - state.height;

            var index = binarySearch(coordinates, c);

            c = coordinates[index];

            state.$target.css("margin-top", c + "px");
            updateTime();
        }

        function moveupTmp(diff){
          var c = state.margin_top + diff;

          var index = binarySearch(coordinates, c + state.height);

          c = coordinates[index];

          state.$target.css("margin-top", c + "px");

          c1 = c - diff;

          var index1 = binarySearch(coordinates, c1);

          if(index == timeElems.length - 2 && index == binarySearch(coordinates, c)) index++;

          var h = coordinates[index1] - c + state.height;

          state.$target.css("height", h + "px");

          updateTime();
        }

        function moveDown(diff) {
            var h = state.height + diff;

            var c = state.margin_top + h;

            var index = binarySearch(coordinates, c);

            c = coordinates[index]  + $(timeElems[index]).getHeight();

            h = c - state.margin_top;

            state.$target.css("height", h  + "px");
            updateTime();
        }

        function scale(e) {
            detectBorder(e);

            if (state != null) {
                var diff = e.pageY - state.y;

                if(state.isTmp) scaleTmp(diff);
                else (state.dir == "up") ? moveUp(diff) : moveDown(diff);
            }
        }

        function scaleTmp(diff){
          (diff <= 0) ? moveupTmp(diff) : moveDown(diff);

          calendar.append(state.$target);
        }

        function finishScaling(e) {
            clearTimeout(cancelClick);

            if (state != null && !isClick) {
              if(state.isTmp){
                if(renderForm2 != null && e.which == 1){
                  var c = parseInt(state.$target.css("margin-top"));
                  var ch = parseInt(state.$target.css("height")) + c;

                  var startIndex = binarySearch(coordinates, c);
                  var endIndex = binarySearch(coordinates, ch + 1)

                  if(ch >= coordinates[coordinates.length - 1]) endIndex++;

                  var $start = $(timeElems[startIndex]);
                  var $end = $(timeElems[endIndex]);

                  renderForm2($start, $end);
                }
              }
              else if(renderForm1 != null){
                var duration = getTime();

                var startTime = duration[0];
                var endTime = duration[1];

                renderForm1(state.$target, startTime, endTime)
              };
            }

            if (state != null && state.isTmp) state.$target.remove();

            state = null;
            isClick = true;
        }

        function updateTime(){
          var $this = state.$target;

          var margin_top = parseInt($this.css("margin-top"));
          var height = parseInt($this.css("height"));

          var startTime = searchTime(margin_top);
          var endTime = searchTime(margin_top + height);

          var duration = startTime + " - " + endTime;

          state.$writeTarget.text(duration);
          state.$target.attr("data-original-title", duration);
        }

        function getTime(){
          return state.$writeTarget.text().split("-").map(str => str.trim());
        }

        function searchTime(coordinate) {
            var index = binarySearch(coordinates, coordinate);

            var percent = (coordinate - coordinates[index]) / $(timeElems[index]).getHeight();

            var nearestTime = new Date(parseInt(timeElems.eq(index).attr("time-data")));

            nearestTime.setMinutes(nearestTime.getMinutes() + 30 * percent);

            var h = nearestTime.getHours();
            var m = nearestTime.getMinutes();

            var hh = (h < 10) ? ("0" + h) : h;
            var mm = (m < 10) ? ("0" + m) : m;

            return hh + ":" + mm;
        }

        function detectElem(e, earlyReturn) {
            var target = e.target;
            var $target = $(target);

            if (!$target.hasClass("cal-day-hour-part")) {
                $target = $target.parent(".cal-day-hour-part");
                target = $target[0];
            }

            if (earlyReturn && target == null) return null;

            if (target == null) {
                var $target = $(e.target).parent(".day-event");
                var index = binarySearch(coordinates, parseInt($target.css("margin-top")));
                target = timeElems[index];
            }

            return $target;
        }

        if (day_schedule_counter % 2 == 0) {
            calendar.mousemove(scale)
                .mouseup(finishScaling)
                .children(".day-event")
                .mousedown(initScaling);

            timeElems.mousedown(detectStart);
        }
    }
}
