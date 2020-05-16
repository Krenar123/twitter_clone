//= link_directory ../javascripts .js 

const but_modal = document.querySelectorAll('.button_modal')
const modal = document.getElementById('modal')
const close = document.getElementsByClassName('button')


but_modal.forEach(button => 
    button.addEventListener("click", () => modal.style.display = 'block')
);
