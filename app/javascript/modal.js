document.addEventListener('turbolinks:load', () => {
    const btnCloseModal = document.querySelector(".button")
    const btnOpenLikesModals = document.querySelectorAll(".fa-gratipay")
    const btnOpenRetweetsModals = document.querySelectorAll('.fa-comments')

    const modal = document.querySelector(".modal")
    const anotherClose = document.querySelector(".delete")

    btnCloseModal.addEventListener("click", function(e){
        modal.classList.remove("is-active")
    })
    for (const buttons of btnOpenLikesModals) {
        buttons.addEventListener("click", function(e){
            modal.classList.add("is-active")
        })
    }
    for (const buttons of btnOpenRetweetsModals) {
      buttons.addEventListener("click", function(e){
          modal.classList.add("is-active")
      })
    }
    anotherClose.addEventListener("click",function(){
        modal.classList.remove("is-active")
    })

    //Navbar here because it doesnt work with navbar.js

    const $navbarBurgers = Array.prototype.slice.call(document.querySelectorAll('.navbar-burger'), 0);
  
    // Check if there are any navbar burgers
    if ($navbarBurgers.length > 0) {
  
      // Add a click event on each of them
      $navbarBurgers.forEach( el => {
        el.addEventListener('click', () => {
  
          // Get the target from the "data-target" attribute
          const target = el.dataset.target;
          const $target = document.getElementById(target);
  
          // Toggle the "is-active" class on both the "navbar-burger" and the "navbar-menu"
          el.classList.toggle('is-active');
          $target.classList.toggle('is-active');
  
        });
      });
    }
});