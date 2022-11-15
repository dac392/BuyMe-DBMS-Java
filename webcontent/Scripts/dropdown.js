const category = document.querySelector('#dropdown-trigger1');
const subcategory = document.querySelector('#dropdown-trigger2');
const specification = document.querySelector('#dropdown-trigger3');

const dropdown1 = document.querySelector('#dropdown1');
const dropdown2 = document.querySelector('#dropdown2');
const dropdown3 = document.querySelector('#dropdown3');
const options = document.querySelectorAll('.option');
const selectLabel1 = document.querySelector('#select-label1');
const selectLabel2 = document.querySelector('#select-label3');
const selectLabel3 = document.querySelector('#select-label3');

function onButtonClick(e){
	e.preventDefault();
	console.log(e.target);

}

function toggle(component){
	component.classList.toggle('hidden');
}

function addEventListener(opt){
	opt.addEventListener('click', (e)=>{
		const labelElement = document.querySelector(`label[for="${e.target.id}"]`).innerText;
		selectLabel.innerText = labelElement;
		toggle();
	})
}

category.addEventListener('click', onButtonClick);
subcategory.addEventListener('click', onButtonClick);
specification.addEventListener('click', onButtonClick);

options.forEach((option)=>addEventListener(option));



