import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    open(event) {
        event.preventDefault();
        this.element.showModal()
    }
}
