const category = document.getElementById("category");
const sub = document.getElementById("sub-category");
const size = document.getElementById("size");

function onFirstLoad(){
	sub.disabled = true;
	size.disabled = true;
	
}

function onCategoryChange(e){
	const type = e.target.value;
	sub.disabled = false;
	size.disabled = false;

	filter(sub.children, type);
	filter(size.children, type);


}

function filter(options, type){

	for(let i = 1; i < options.length; i++){
		if(options[i].attributes["category"].textContent === type){
			
			options[i].style.display = "";
		}else{
			options[i].style.display = "none";
		}
	}
}

/* --------main------------ */
onFirstLoad();
category.addEventListener("change", onCategoryChange);



