var day_schedule_counter = 0;

function day_schedule() {
    var timeElems = $(".cal-day-hour-part");
    var times = timeElems.map((index, value) => $(value).text().trim()).get();
    var coordinates = timeElems.map((index, value) => $(value).position().top).get();
    var calendar = $("#cal-day-panel");

    day_schedule_counter++;

    console.log("counter " + day_schedule_counter);

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

    this.daySize = function (renderForm1, renderForm2) {
        var state = null;

        function initScaling(e) {
            var $this = $(this);

            var offset = e.offsetY;
            var y = e.pageY;
            var height = parseInt($this.css("height"));
            var margin_top = parseInt($this.css("margin-top"));

            var allowed = 10;

            if (offset <= allowed || height - offset <= allowed) {
                state =
                    {
                        height: height,
                        margin_top: margin_top,
                        y: y,
                        dir: (offset <= allowed) ? "up" : "down",
                        target: this,
                        $target: $this,
                        $writeTarget: $this.find(".cal-hours"),
                        isTmp: false
                    };
            }
        }

        function detectStart(e) {
            $target = detectElem(e, true);

            if($target != null){
              var div =
                "<div class='pull-left day-event day-highlight dh-' style='margin-top:{0}px; height: {1}px' data-time='{2}'><span class='cal-hours'></span></div>"
                .replace("{0}", $target.position().top)
                .replace("{1}", $target.height())
                .replace("{2}", $target.text().trim());

              var $div = $(div);

              state =
              {
                height : $target.height(),
                margin_top : $target.position().top,
                y : e.pageY,
                $target : $div,
                $writeTarget: $div.find(".cal-hours"),
                isTmp : true,
              }

              console.log(state);
            }
        }

        function moveUp(diff) {
            var c = state.margin_top + diff;
            var maxheight = calendar.height();

            if(c + state.height >= maxheight) c = maxheight - state.height;

            var index = binarySearch(coordinates, c);

            c = coordinates[index];

            state.$target.css("margin-top", c + "px");
            updateTime();
        }

        function moveupTmp(diff){
          var c = state.margin_top + diff;
          var maxheight = calendar.height();

          var index = binarySearch(coordinates, c + state.height);

          c = coordinates[index];

          state.$target.css("margin-top", c + "px");

          c1 = c - diff;

          var index1 = binarySearch(coordinates, c1);

          var h = coordinates[index1] - c + state.height;

          state.$target.css("height", h + "px");

          updateTime();
        }

        function moveDown(diff) {
            var h = state.height + diff;

            var c = state.margin_top + h;

            var index = binarySearch(coordinates, c);

            if(c > coordinates[index + 1]) index++;

            c = coordinates[index]  + $(timeElems[index]).height();

            h = c - state.margin_top;

            state.$target.css("height", h  + "px");
            updateTime();
        }

        function scale(e) {
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

        function finishScaling() {
            if (state != null) {
              var duration = getTime();

              var startTime = duration[0];
              var endTime = duration[1];

              if(state.isTmp){
                if(renderForm2 != null){
                  var $start = $(timeElems[times.indexOf(startTime)]);
                  var $end = $(timeElems[times.indexOf(endTime)]);
                  renderForm2($start, $end);
                }
                state.$target.remove();
              }
              else {
                if(renderForm1 != null) renderForm1(state.$target, startTime, endTime);
              }
            }

            state = null;
        }

        function updateTime(){
          var $this = state.$target;

          var margin_top = parseInt($this.css("margin-top"));
          var height = parseInt($this.css("height"));

          var startTime = searchTime(margin_top);
          var endTime = searchTime(margin_top + height);

          state.$writeTarget.text(startTime + " - " + endTime);
        }

        function getTime(){
          return state.$writeTarget.text().split("-").map(str => str.trim());
        }

        function searchTime(coordinate) {
            var index = binarySearch(coordinates, coordinate);

            // console.log("index " + index)

            var percent = (coordinate - coordinates[index]) / $(timeElems[index]).height();

            // console.log("percent " + percent);

            var nearestTime = new Date(Date.parse("1/1/1 " + times[index]));

            nearestTime.setMinutes(nearestTime.getMinutes() + 30 * percent);

            var h = nearestTime.getHours();
            var m = nearestTime.getMinutes();

            m = Math.floor(m / 30) * 30;

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
