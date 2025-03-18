import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["sidebar"];

  connect() {
    const isSidebarExpanded = localStorage.getItem("sidebarExpanded") === "true";

    if (isSidebarExpanded) {
      this.expand();
    } else {
      this.retract();
    }
  }

  expand() {
    console.log("expand");
    this.sidebarTarget.classList.add("expanded");

    localStorage.setItem("sidebarExpanded", true);
  }

  retract() {
    console.log("retract");
    this.sidebarTarget.classList.remove("expanded");

    localStorage.setItem("sidebarExpanded", false);
  }

  toggle() {
    if (this.sidebarTarget.classList.contains("expanded")) {
      this.retract();
    } else {
      this.expand();
    }
  }
}
