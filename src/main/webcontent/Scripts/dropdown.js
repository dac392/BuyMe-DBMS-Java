const button = document.querySelector('#dropdown-trigger');
const dropdown = document.querySelector('#dropdown');
const options = document.querySelectorAll('.option');
const selectLabel = document.querySelector('#select-label');

function onButtonClick(e){
	e.preventDefault();
	toggle();
}

function toggle(){
	dropdown.classList.toggle('hidden');
}

function addEventListener(opt){
	opt.addEventListener('click', (e)=>{
		const labelElement = document.querySelector(`label[for="${e.target.id}"]`).innerText;
		selectLabel.innerText = labelElement;
		toggle();
	})
}

button.addEventListener('click', onButtonClick);
options.forEach((option)=>addEventListener(option));