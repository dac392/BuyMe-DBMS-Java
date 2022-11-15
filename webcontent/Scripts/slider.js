const buttons = document.getElementsByName("slide");
const container = document.getElementById("frame");
const source = document.getElementsByClassName("source");

buttons.forEach((button)=>{
	button.addEventListener('click', (event)=>{
		
		if(event.target.id === "img1"){
			frame.src = source[0].textContent;
		}else if(event.target.id === "img2"){
			frame.src = source[1].textContent;
		}else if(event.target.id === "img3"){
			frame.src = source[2].textContent;
		}

	})
})