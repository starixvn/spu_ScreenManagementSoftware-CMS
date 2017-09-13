function daySize(){
    var timeElems = $(".cal-day-hour-part");
    var times = timeElems.map((index,value) => $(value).text().trim()).get();
    var coordinates = timeElems.map((index,value) => $(value).position().top).get();
    var maxheight = $("#cal-day-panel").height();
    
    var state = null;

    function initScaling(e){
        var $this = $(this);

        var offset = e.offsetY;
        var y = e.pageY;
        var height = parseInt($this.css("height"));
        var margin_top = parseInt($this.css("margin-top"));

        var allowed = 10;

        if(offset <= allowed || height - offset <= allowed)
        {		
            state =
            {
                height: height,
                margin_top: margin_top,
                y: y,
                dir: (offset <= 5) ? "up":"down",
                target: this,
                $target: $this
            };

            console.log("move " + state.dir);
        }
    }

    function moveUp(diff){             
        state.$target.css("margin-top", Math.max((state.margin_top + diff), 0) + "px");
    }

    function moveDown(diff){
        state.$target.css("height", Math.min(state.height + diff, maxheight - state.margin_top)+ "px");
    }

    function scale(e){
        if(state != null){
            var diff = e.pageY - state.y;

            (state.dir == "up") ? moveUp(diff) : moveDown(diff);
        }
    }


    function finishScaling(){
        if(state != null){
            var $this = $(this);

            var margin_top = parseInt($this.css("margin-top"));
            var height = parseInt($this.css("height"));

            //console.log("margin-top " + margin_top);
            //console.log("height " + height);

            var startTime = searchTime(margin_top);
            var endTime = searchTime(margin_top + height);

            console.log(startTime + " - " + endTime);

            var $span = $this.find("span")
            $span.text(startTime + " - " + endTime);
        }

        state = null;
    }

    function searchTime(coordinate){
        var index = binarySearch(coordinates, coordinate);

        console.log("index " + index)

        var percent = (coordinate - coordinates[index]) / $(timeElems[index]).height();

        console.log("percent " + percent);

        var nearestTime = new Date(Date.parse("1/1/1 " + times[index]));

        nearestTime.setMinutes(nearestTime.getMinutes() + 30 * percent);

        var h = nearestTime.getHours();
        var m = nearestTime.getMinutes();
        var s = nearestTime.getSeconds();

        var hh = (h < 10) ? ("0" + h) : h;
        var mm = (m < 10) ? ("0" + m) : m;
        var ss = (s < 10) ? ("0" + s) : s;

        return hh + ":" + mm + ":" + ss;
    }

    function binarySearch(arr, target){
        return binarySearchSub(arr, target, 0, arr.length - 1);
    }

    function binarySearchSub(arr, target, start, end){
        if(end - start + 1 == 2){
            return start;
        }
        else{
            var m = Math.floor((start + end) / 2);
            var vm =arr[m];

            return (target < vm) ? binarySearchSub(arr, target, start, m) : binarySearchSub(arr, target, m, end)
        }
    }

    $("#cal-day-panel")
        .mousemove(scale)
        .children(".day-event")
        .mousedown(initScaling)
        .mouseup(finishScaling)      
}

daySize();