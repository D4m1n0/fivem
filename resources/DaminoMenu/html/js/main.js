window.onload = (e) => {
	window.addEventListener('message', (event) => {
		let item = event.data;

		if (item !== undefined && item.type === "open") {
			if (item.display) {
        document.getElementById('menu').classList.add('show');
				if(document.getElementsByClassName('menu__container').length > -1) {
					removeChildren();
				}
				createTitle(item.item.title)
				createMenu(item.item.fields)
			}else if (item !== undefined && item.type !== "open") {
				removeChildren();
        document.getElementById('menu').classList.remove('show');
      }
		}
		if (item !== undefined && item.type === "navigate") {
			let activeContainer = document.getElementsByClassName('active')[0];
			let container = document.getElementsByClassName('menu__container');

			if(item.key === "up") {
				activeContainer.classList.remove('active');
				if(activeContainer.previousElementSibling !== null) {
					activeContainer.previousElementSibling.classList.add('active');
				}else {
					container[container.length].classList.add('active');
				}
			}else if(item.key === "down") {
				activeContainer.classList.remove('active');
				if(activeContainer.nextElementSibling !== null) {
					activeContainer.nextElementSibling.classList.add('active');
				}else {
					container[0].classList.add('active');
				}
			}else if(item.key === "enter") {
				let nodes = Array.prototype.slice.call( document.getElementById('menu').children )
		    let indexOfActive = nodes.indexOf( activeContainer );
				let data = item.item.fields[indexOfActive-1];

				if(activeContainer.dataset["type"] === "checkbox") {
					if(activeContainer.querySelector('input[type="checkbox"]').checked) {
						activeContainer.querySelector('input[type="checkbox"]').checked = "";
						data["value"] = false;
					} else {
						activeContainer.querySelector('input[type="checkbox"]').checked = "checked";
						data["value"] = true;
					}
					sendData(data)
				}else if(activeContainer.dataset["type"] === "item") {
					/* Add submenu */
					sendData(data)
				}else if (activeContainer.dataset["type"] === "close") {
					removeChildren();
	        document.getElementById('menu').classList.remove('show');
				}else if (activeContainer.dataset["type"] === "submenu") {
					removeChildren();
				}
			}
		}
	});

	function sendData(data) {
		console.log(data.event, JSON.stringify(data))
		let xhr = new XMLHttpRequest();
		xhr.open("POST", data.event, true);
		xhr.setRequestHeader('Content-Type', 'application/json');
		xhr.send(JSON.stringify({
			'data': data.value
		}));
	}

	function removeChildren() {
		let menu = document.getElementsByClassName('menu')[0];
		let menuContainer = document.getElementsByClassName('menu__container');
		for (var i = 0; i < menuContainer.length; i++) {
			menu.removeChild(menuContainer[i]);
		}
		if(document.getElementsByClassName('menu__title-h')[0] !== undefined) {
			menu.removeChild(document.getElementsByClassName('menu__title-h')[0]);
		}
	}

	function createTitle(title) {
		let menuContainer = document.getElementsByClassName('menu')[0];

		let h1 = document.createElement('h1');
		h1.classList.add('menu__title-h');
		h1.innerText = title;

		menuContainer.appendChild(h1);
	}

	function createMenu(fields) {
		for (let i = 0; i < fields.length; i++) {
			if(fields[i].type === "checkbox") {
				createCheckbox(fields[i], i);
			}else if(fields[i].type === "item") {
				createSimpleItem(fields[i], i);
			}else if(fields[i].type === "submenu") {
				createSubmenuItem(fields[i], i);
			}
		}
		createCloseItem();
	}

	function createCheckbox(data, index) {
		let menuContainer = document.getElementsByClassName('menu')[0];

		let container = document.createElement('div');
		container.classList.add('menu__container');
		if(index === 0){
			container.classList.add('active');
		}
		container.dataset['type'] = "checkbox";
		container.dataset['event'] = data.event;
		let label = document.createElement('span');
		label.classList.add('menu__title');
		label.innerText = data.title
		let input = document.createElement('input');
		input.type = "checkbox";
		input.classList.add('menu__checkbox');
		if(data.value) {
			input.checked = 'checked';
		}

		menuContainer.appendChild(container);
		container.appendChild(label);
		container.appendChild(input);
	}
	function createSubmenuItem(data, index) {
		let menuContainer = document.getElementsByClassName('menu')[0];

		let container = document.createElement('div');
		container.classList.add('menu__container');
		container.classList.add('menu__submenu');
		if(index === 0){
			container.classList.add('active');
		}
		container.dataset['type'] = "submenu";
		container.dataset['event'] = data.event;
		container.dataset['index'] = index;
		let label = document.createElement('span');
		label.classList.add('menu__title');
		label.innerText = data.title

		menuContainer.appendChild(container);
		container.appendChild(label);
	}
	function createSimpleItem(data, index) {
		let menuContainer = document.getElementsByClassName('menu')[0];

		let container = document.createElement('div');
		container.classList.add('menu__container');
		if(index === 0){
			container.classList.add('active');
		}
		container.dataset['type'] = "item";
		container.dataset['event'] = data.event;
		let label = document.createElement('span');
		label.classList.add('menu__title');
		label.innerText = data.title

		menuContainer.appendChild(container);
		container.appendChild(label);
	}
	function createCloseItem() {
		let menuContainer = document.getElementsByClassName('menu')[0];

		let container = document.createElement('div');
		container.classList.add('menu__container');

		container.dataset['type'] = "close";
		container.dataset['event'] = "";
		let label = document.createElement('span');
		label.classList.add('menu__title');
		label.innerText = "Fermer"

		menuContainer.appendChild(container);
		container.appendChild(label);
	}
};
