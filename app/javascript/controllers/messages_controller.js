import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { currentUserId: Number }

  connect() {
    this.alignMessages()
    this.applyAvatars()
  }

  alignMessages() {
    this.element.querySelectorAll(".message").forEach(message => {
      const senderId = Number(message.dataset.userId)

      if (senderId === this.currentUserIdValue) {
        message.classList.add("from-me")
      } else {
        message.classList.add("from-them")
      }
    })
  }

  applyAvatars() {
    this.element.querySelectorAll(".message").forEach(message => {
      const avatar = message.querySelector(".avatar-chat")
      if (!avatar) return

      const role = message.dataset.userRole

      if (role === "vet") {
        avatar.src =
          "https://res.cloudinary.com/rts1307/image/upload/v1771606859/development/gregoryhouse.jpg"
      } else if (role === "owner") {
        const petPhotoUrl = message.dataset.petPhotoUrl
        if (petPhotoUrl && petPhotoUrl.length > 0) {
          avatar.src = petPhotoUrl
        }
      }
    })
  }
}
