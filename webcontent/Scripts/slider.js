const buttons = document.getElementsByName("slide");
const container = document.getElementById("frame");
const source = document.getElementsByClassName("source");



/*--------main----------*/
//getImage("image1.png");
buttons.forEach((button)=>{
	button.addEventListener('click', (event)=>{
		
		if(event.target.id === "img1"){
			container.src = source[0].textContent;

		}else if(event.target.id === "img2"){
			container.src = source[1].textContent;

		}else if(event.target.id === "img3"){
			container.src = source[2].textContent;

		}

	})
})