window.onload = (e) => {
    window.addEventListener('message', (event) => {
        if(event.data.type === "speedometer") {
            if(event.data.display) {
                document.getElementsByClassName('speedometer')[0].classList.add('d-block')
            } else {
                document.getElementsByClassName('speedometer')[0].classList.remove('d-block')
            }
            let speed = event.data.speed - 90
            document.getElementsByClassName('needle')[0].style.setProperty("--speed", speed+"deg")
            document.getElementsByClassName('speedometer__text')[0].innerText = Math.floor(event.data.speed)+"km/h"
        }
    })
}