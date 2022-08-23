window.closeAllModal = () => {
  document.querySelectorAll(".modal").forEach((modal) => {
    modal.style.display = "none"
  })
}

document.addEventListener("DOMContentLoaded", () => {
  document.addEventListener("click", (e) => {
    //  e.target will be the icon element
    // and e.target.closest("[data-modal-class]") will get the modal class name
    if (e.target) {
      const modalElm = e.target.closest("[data-modal-class]")

      if (!modalElm) {
        return
      }

      const modalClass = modalElm.getAttribute("data-modal-class")

      if (e.target.parentElement) {
        var parentClasses = e.target.parentElement.classList
        const modal = document.querySelector(`[data-modal-class=${modalClass}]`)
        if (parentClasses.contains("js-modal-close")) {
          e.preventDefault()
          modal.style.display = "none"
        } else if (parentClasses.contains("js-modal-open")) {
          e.preventDefault()
          modal.style.display = "block"
        }
      }
    }
  })

  document.addEventListener("keydown", (evt) => {
    evt = evt || window.event
    var key = evt.key || evt.keyCode

    if (key === "Escape" || key === "Esc" || key === 27) {
      window.closeAllModal()
    }
  })
})
