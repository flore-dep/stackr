import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="license-bar"
export default class extends Controller {
  static targets = [
    "pending",
    "approved",
    "declined",
    "toggle",
    "pendingLicenses",
    "approvedActiveLicenses",
    "approvedPastLicenses",
    "declinedLicenses"
  ]

  connect() {
    this.reset()
    this.setApproved()
  };

  setPending() {
    this.reset();
    this.pendingTarget.classList.add('active');
    this.pendingLicensesTarget.classList.remove('d-none')
  };

  setApproved() {
    this.reset()
    this.approvedTarget.classList.add('active');
    this.toggleTarget.classList.remove('d-none')
    this.toggleTarget.querySelector("input").checked = true;
    this.toggleTarget.querySelector("label").innerText = "Active";
    this.approvedActiveLicensesTarget.classList.remove('d-none')
  };

  setDeclined() {
    this.reset()
    this.declinedTarget.classList.add('active');
    this.declinedLicensesTarget.classList.remove('d-none')
  };

  toggleToggle() {
    if (this.toggleTarget.querySelector("input").checked) {
      this.toggleTarget.querySelector("label").innerText = "Active";
      this.approvedPastLicensesTarget.classList.add('d-none')
      this.approvedActiveLicensesTarget.classList.remove('d-none')
    } else {
      this.toggleTarget.querySelector("label").innerText = "Past";
      this.approvedActiveLicensesTarget.classList.add('d-none')
      this.approvedPastLicensesTarget.classList.remove('d-none')
    }

  };

  reset() {
      this.pendingTarget.classList.remove('active')
      this.approvedTarget.classList.remove('active')
      this.declinedTarget.classList.remove('active')
      this.toggleTarget.classList.add('d-none')
      this.pendingLicensesTarget.classList.add('d-none')
      this.approvedActiveLicensesTarget.classList.add('d-none')
      this.approvedPastLicensesTarget.classList.add('d-none')
      this.declinedLicensesTarget.classList.add('d-none')
    };
  }
