import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="menu"
export default class extends Controller {
  static targets = ["items"]

  open(){
    this.itemsTarget.classList.remove('-translate-x-full')
  }

  close(){
    this.itemsTarget.classList.add('-translate-x-full')
  }
}
