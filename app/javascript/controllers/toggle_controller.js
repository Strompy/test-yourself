import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle"
export default class extends Controller {
  static targets = ["answer"];   

  connect() {
  }

  toggle() {
    this.answerTarget.removeAttribute('hidden')
  }
}
