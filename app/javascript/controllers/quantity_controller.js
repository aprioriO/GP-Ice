import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["quantity"];

  decrease() {
    let input = this.quantityTarget;
    let value = parseInt(input.value, 10);
    if (value > 1) {
      input.value = value - 1;
    }
  }

  increase() {
    let input = this.quantityTarget;
    let value = parseInt(input.value, 10);
    input.value = value + 1;
  }
}
