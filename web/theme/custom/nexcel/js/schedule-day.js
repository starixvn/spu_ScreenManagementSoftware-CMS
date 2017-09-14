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

    this.daySize = function (renderForm) {
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
                        $target: $this
                    };

                console.log("move " + state.dir);
            }
        }

        function moveUp(diff) {
            var c = state.margin_top + diff;

            var index = binarySearch(coordinates, c);

            c = coordinates[index];

            state.$target.css("margin-top", c + "px");
        }

        function moveDown(diff) {
            var h = state.height + diff;

            var c = state.margin_top + h;

            var index = binarySearch(coordinates, c);

            if(c > coordinates[index + 1]) index++;

            c = coordinates[index]  + $(timeElems[index]).height();

            h = c - state.margin_top;

            state.$target.css("height", h  + "px");
        }

        function scale(e) {
            if (state != null) {
                var diff = e.pageY - state.y;

                (state.dir == "up") ? moveUp(diff) : moveDown(diff);
            }
        }

        function finishScaling() {
            if (state != null) {
                var $this = state.$target;

                var margin_top = parseInt($this.css("margin-top"));
                var height = parseInt($this.css("height"));

                var startTime = searchTime(margin_top);
                var endTime = searchTime(margin_top + height);

                console.log(startTime + " - " + endTime);

                var $span = $this.find("span")
                $span.text(startTime + " - " + endTime);

                if (renderForm != null) {
                    renderForm(state.$target, startTime, endTime);
                }
            }

            state = null;
        }

        function searchTime(coordinate) {
            var index = binarySearch(coordinates, coordinate);

            console.log("index " + index)

            var percent = (coordinate - coordinates[index]) / $(timeElems[index]).height();

            console.log("percent " + percent);

            var nearestTime = new Date(Date.parse("1/1/1 " + times[index]));

            nearestTime.setMinutes(nearestTime.getMinutes() + 30 * percent);

            var h = nearestTime.getHours();
            var m = nearestTime.getMinutes();

            m = Math.floor(m / 30) * 30;

            var hh = (h < 10) ? ("0" + h) : h;
            var mm = (m < 10) ? ("0" + m) : m;

            return hh + ":" + mm;
        }

        if (day_schedule_counter % 2 == 0) {
            console.log("daySize loaded");

            calendar
		        .mousemove(scale)
				    .mouseup(finishScaling)
		        .children(".day-event")
		        .mousedown(initScaling);
        }
    }

    this.daySelect = function (renderForm) {

        function detectElem(e, earlyReturn) {
            var target = e.target;
            var $target = $(target);

            if (!$target.hasClass("cal-day-hour-part")) {
                $target = $target.parent(".cal-day-hour-part");
                target = $target[0];
            }

            if (earlyReturn && target == null)
            {
                return null;
            }

            if (target == null) {
                var $target = $(e.target).parent(".day-event");
                var index = binarySearch(coordinates, parseInt($target.css("margin-top")));
                target = timeElems[index];
            }

            return target;
        }

        function detectStart(e) {
            calendar.start = detectElem(e, true);
            console.log(calendar.start);
        }

        function detectEnd(e) {
            var start = calendar.start;

            if (start != null) {
                var end = detectElem(e, false);

                console.log(end);

                if (renderForm != null) {
                    renderForm($(start), $(end));
                }
            }

            calendar.start = null;
        }

        if (day_schedule_counter % 2 == 0) {
            console.log("daySelect loaded");
            calendar.mousedown(detectStart).mouseup(detectEnd);
        }
    }
}
