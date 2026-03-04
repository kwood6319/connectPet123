import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    // Finds the viewer ID and pet photo URL from the
    this.viewerId = this.element.dataset.viewerId
    this.petPhotoUrl = this.element.dataset.petPhotoUrl

    // Runs the applyPerspective method on connect
    this.applyPerspective()

    // Adds an observer that checks the DOM for changes
    this.observer = new MutationObserver(mutations => {
      mutations.forEach(mutation => {
        // When Turbo adds a new message, it detects ".message" calls applytoMessage method
        mutation.addedNodes.forEach(node => {
          // nodeType 1 = element_node (HTML elements like div, p, span, etc.)
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
    // Finds sender Id and Role from dataset
    const senderId = message.dataset.userId
    const senderRole = message.dataset.userRole

    // Finds the areas that need styling
    const bubble = message.querySelector(".msg")
    const avatarSlot = message.querySelector(".avatar-slot")
    const row = message

    const fromMe = senderId === this.viewerId

    // Reset classes because I was having issues with class overlaps
    row.classList.remove("msg-left", "msg-right")
    bubble.classList.remove("msg-left", "msg-right")

    // Checks if the message is from current user, if so, uses msg-right and if not, uses msg-left
    row.classList.add(fromMe ? "msg-right" : "msg-left")
    bubble.classList.add(fromMe ? "msg-right" : "msg-left")

    // Sets image of the vet (House) or the pet's image depending on role
    const avatarSrc =
      senderRole === "vet"
        ? "https://res.cloudinary.com/rts1307/image/upload/v1771606859/development/gregoryhouse.jpg"
        : this.petPhotoUrl

    // Interpolates HTML and adds to the DOM
    avatarSlot.innerHTML = `
      <img
        class="avatar-chat ${fromMe ? "right-avatar" : "left-avatar"}"
        src="${avatarSrc}"
      />
    `
  }
}
