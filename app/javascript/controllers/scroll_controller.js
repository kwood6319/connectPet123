// Method to auto-scroll to the bottom of the message container
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.scrollToBottom()
    // When the page loads, run the scrollToBottom method

    // Watches for changes in the DOM (a new message being appended to the DOM) and then runs the scroll method
    this.observer = new MutationObserver(() => {
      this.scrollToBottom()
    })

    // Tells the observer to look for changes specifically in the DOM element the controller is attached to <div id="chat-messages" data-controller="scroll-messages"></div>
    this.observer.observe(this.element, {
      // Allows the observer to check even if the change is a child
      childList: true,
      // Allows the observer to look deeper in the DOM
      subtree: true
    })
  }

  // Cleans up when navigating away from the page
  disconnect() {
    this.observer?.disconnect()
  }

  // Creates a method to scroll to the ottom
  scrollToBottom() {
    // Turbo inserts the message asynchronously so we need to double frame it to ensure the DOM updates, layout recalculates, then scrolls
    requestAnimationFrame(() => {
      requestAnimationFrame(() => {
        this.element.scrollTop = this.element.scrollHeight
        // scrollTop = the top of where your scroll should be set (the highest point you see)
        // scrollHeight = How much the DOM can scroll
      })
    })
  }
}
