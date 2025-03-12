import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dropdown"
export default class extends Controller {
  static targets = ["menu", "arrow"];

  toggle () {
    this.menuTarget.classList.toggle("active");
    this.arrowTarget.classList.toggle("active");
  }

  hide(event) {
    if (!this.element.contains(event.target)) {
      this.menuTarget.classList.remove("active");
      this.arrowTarget.classList.remove("active");
    }
  }
}
