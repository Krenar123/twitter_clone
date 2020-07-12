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
});