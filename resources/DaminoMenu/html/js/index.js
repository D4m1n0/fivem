window.onload = (e) => {
	window.addEventListener('message', (event) => {
		var item = event.data;
		if (item !== undefined && item.type === "ui") {
			if (item.display) {
        document.getElementById('container').classList.add('show');
			}else {
        document.getElementById('container').classList.remove('show');
      }
		}
	});
};
