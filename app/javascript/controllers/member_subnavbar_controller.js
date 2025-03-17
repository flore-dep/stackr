import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="license-bar"
export default class extends Controller {
  static targets = [
    "coming",
    "active",
    "gone",
    "comingMembers",
    "activeMembers",
    "goneMembers"
  ]

  connect() {
    console.log("connected")
    this.reset()
    this.setActive()
  };

  setComing() {
    this.reset();
    this.comingTarget.classList.add('active');
    this.comingMembersTarget.classList.remove('d-none')
  };

  setActive() {
    this.reset()
    this.activeTarget.classList.add('active');
    this.activeMembersTarget.classList.remove('d-none')
  };

  setGone() {
    this.reset()
    this.goneTarget.classList.add('active');
    this.goneMembersTarget.classList.remove('d-none')
  };

  reset() {
      this.comingTarget.classList.remove('active')
      this.activeTarget.classList.remove('active')
      this.goneTarget.classList.remove('active')
      this.comingMembersTarget.classList.add('d-none')
      this.activeMembersTarget.classList.add('d-none')
      this.goneMembersTarget.classList.add('d-none')
    };
  }
