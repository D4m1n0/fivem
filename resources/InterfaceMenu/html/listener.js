$(function(){
	window.onload = (e) => {
		window.addEventListener('message', (event) => {
			var item = event.data;
			if (item !== undefined && item.type === "ui") {
				if (item.display) {
        	$("#container").hide();
				}else {
          $("#container").show();
        }
			}
		});
	};
});
