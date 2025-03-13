import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["team", "form"]

  connect() {
   const select = new URLSearchParams(window.location.search).get('q')
   console.log(select)

   if (select) {
    this.teamTarget.value = select;
   }
  }

  filter() {
    console.log(this.teamTarget.value);

    window.location.href = `${this.formTarget.action}?q=${this.teamTarget.value}`;

    // fetch(`${this.formTarget.action}?q=${this.teamTarget.value}`)
  }

}
