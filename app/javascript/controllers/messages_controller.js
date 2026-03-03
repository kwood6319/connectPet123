import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.viewerId = this.element.dataset.viewerId
    this.petPhotoUrl = this.element.dataset.petPhotoUrl

    this.applyPerspective()

    this.observer = new MutationObserver(mutations => {
      mutations.forEach(mutation => {
        mutation.addedNodes.forEach(node => {
          if (node.nodeType === 1 && node.classList.contains("message")) {
            this.applyToMessage(node)
          }
        })
      })
    })

    this.observer.observe(this.element, {
      childList: true
    })
  }

  disconnect() {
    this.observer?.disconnect()
  }

  applyPerspective() {
    this.element
      .querySelectorAll(".message")
      .forEach(message => this.applyToMessage(message))
  }

  applyToMessage(message) {
    const senderId = message.dataset.userId
    const senderRole = message.dataset.userRole

    const bubble = message.querySelector(".msg")
    const avatarSlot = message.querySelector(".avatar-slot")
    const row = message

    const fromMe = senderId === this.viewerId

    // RESET CLASSES FIRST
    row.classList.remove("msg-left", "msg-right")
    bubble.classList.remove("msg-left", "msg-right")

    // APPLY CORRECT SIDE
    row.classList.add(fromMe ? "msg-right" : "msg-left")
    bubble.classList.add(fromMe ? "msg-right" : "msg-left")

    // AVATAR
    const avatarSrc =
      senderRole === "vet"
        ? "https://res.cloudinary.com/rts1307/image/upload/v1771606859/development/gregoryhouse.jpg"
        : this.petPhotoUrl

    avatarSlot.innerHTML = `
      <img
        class="avatar-chat ${fromMe ? "right-avatar" : "left-avatar"}"
        src="${avatarSrc}"
      />
    `
  }
}
