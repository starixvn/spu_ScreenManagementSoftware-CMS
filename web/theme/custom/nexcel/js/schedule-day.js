function daySize(){
	var timeElems = $(".cal-day-hour-part");
	var times = timeElems.map((index,value) => $(value).text().trim()).get();
	var coordinates = timeElems.map((index,value) => $(value).position().top).get();	

	function initialize(e){
		var $this = $(this);
		
		var offset = e.offsetY;
		var y = e.pageY;
		var height = parseInt($this.css("height"));
		var margin_top = parseInt($this.css("margin-top"));

		var allowed = 10;

		if(offset <= allowed || height - offset <= allowed)
		{		
			var initObj =
			{
				height: height,
				margin_top: margin_top,
				y: y,
				dir: (offset <= 5) ? "up":"down"
			};
			
			console.log("move " + initObj.dir);

			this.init = initObj;
		}
	}

	function moveUp(y, obj, $obj){
		var diff = y - obj.init.y;

		if(diff < 0){
			$obj.css("margin-top", (obj.init.margin_top + diff) + "px");
			$obj.css("height", (obj.init.height + Math.abs(diff)) + "px");
		}
	}

	function moveDown(y, obj, $obj){
		var diff = y - obj.init.y;

		$obj.css("height", (obj.init.height + diff) + "px");
	}

	function scale(e){
		if(this.init != null){
			var y = e.pageY;
			var $this = $(this);

			(this.init.dir == "up") ? moveUp(y,this, $this) : moveDown(y, this, $this);
		}
	}
	
	function finishScaling(){
		if(this.init != null){
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

		this.init = null;
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
		.children(".day-event")
		.mousedown(initialize)
		.mousemove(scale)
		.mouseup(finishScaling)
		.mouseout(finishScaling);
	}
	
daySize();
	