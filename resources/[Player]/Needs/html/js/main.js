window.onload = (e) => {
	window.addEventListener('message', (event) => {
		var item = event.data;
		if (item !== undefined && item.type === "ui") {
			if (item.display) {
        document.getElementById('container').classList.add('show');
			}else {
        document.getElementById('container').classList.remove('show');
      }

      var food = document.querySelector('.needs__food .needs__bar');
      var drink = document.querySelector('.needs__drink .needs__bar');
      var health = document.querySelector('.needs__health .needs__bar');

      food.style.width = item.hunger + "%";
      drink.style.width = item.thirst + "%";
      health.style.width = item.health + "%";
		}
	});
};
