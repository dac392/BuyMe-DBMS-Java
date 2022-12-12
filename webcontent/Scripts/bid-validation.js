const floor = document.getElementById("floor");
const ceil = document.getElementById("ceil");
const ceiling = document.getElementById("ceiling");
const options = document.getElementById("type");
const btn = document.getElementById("submit");

function onStart(){
	ceil.classList.add("hidden");
}

function onChange(e){

	const val = e.target.value; 
	if(val === "auto"){
		ceil.classList.remove("hidden");
		ceiling.addEventListener("keyup", onKeyPress);
	}else{
		ceil.classList.add("hidden");
	}
}

function onKeyPress(e){
	const val = e.target.value;
	const isDecimal = /^\d+(\.\d+)?$/.test(val);
	if(!isDecimal){
		e.target.classList.add('error');
		btn.disabled=true;
	}else{
		e.target.classList.remove("error");
		btn.disabled=false;
	}
}


/* MAIN */
onStart();
options.addEventListener("change", onChange);
floor.addEventListener("keyup", onKeyPress);

