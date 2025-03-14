import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="navbar"
export default class extends Controller {
  static targets = [
    "members",
    "tools",
    "licenses",
    "membersPart",
    "toolsPart",
    "licensesPart",
    "memberIcon",
    "toolIcon",
    "licenseIcon" ]

  connect() {
    console.log(this.hasMembersPartTarget)
  }

  fire(event) {
    this.hideAllPartials()
    this.removeActiveClasses()
    event.currentTarget.classList.add("nvbactive")
    this.showPartial(event.currentTarget)
  }

  hideAllPartials() {
    if (this.hasMembersPartTarget) {
      this.membersPartTarget.classList.add("d-none")
      this.memberIconTarget.classList.add("d-none")
    }
    this.toolsPartTarget.classList.add("d-none")
    this.licensesPartTarget.classList.add("d-none")
    this.toolIconTarget.classList.add("d-none")
    this.licenseIconTarget.classList.add("d-none")
  }

  removeActiveClasses() {
    if (this.hasMembersPartTarget) {
      this.membersTarget.classList.remove("nvbactive")
    }

    this.toolsTarget.classList.remove("nvbactive")
    this.licensesTarget.classList.remove("nvbactive")
  }

  showPartial(button) {
    if (this.hasMembersPartTarget && button === this.membersTarget) {
      this.membersPartTarget.classList.remove("d-none")
      this.memberIconTarget.classList.remove("d-none")
    } else if (button === this.toolsTarget) {
      this.toolsPartTarget.classList.remove("d-none")
      this.toolIconTarget.classList.remove("d-none")
    } else if (button === this.licensesTarget) {
      this.licensesPartTarget.classList.remove("d-none")
      this.licenseIconTarget.classList.remove("d-none")
    }
  }
}
