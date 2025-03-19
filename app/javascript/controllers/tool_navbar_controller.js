import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tool-navbar"
export default class extends Controller {
  static targets = ["reviews", "members", "cost", "reviewsData", "membersData", "costData"]

  connect() {
    this.displayReviews;
  };

  displayReviews(){
    this.reset();
    this.reviewsTarget.classList.add('active');
    this.reviewsDataTarget.classList.add('active');
  };

  displayMembers(){
    this.reset();
    this.membersTarget.classList.add('active');
    this.membersDataTarget.classList.remove('d-none');
    this.membersDataTarget.classList.add('active');
  };

  displayCost(){
    this.reset();
    this.costTarget.classList.add('active');
    this.costDataTarget.classList.remove('d-none');
    this.costDataTarget.classList.add('active');
  };

  reset(){
    this.reviewsTarget.classList.remove('active');
    this.membersTarget.classList.remove('active');
    this.costTarget.classList.remove('active');
    this.reviewsDataTarget.classList.remove('active');
    this.membersDataTarget.classList.remove('active');
    this.costDataTarget.classList.remove('active');
  }
}
