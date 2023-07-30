import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="modals"
export default class extends Controller {
  connect() {}

  // Handle the click event on the "Import CSV" link
  submitForm(e) {modal
    e.preventDefault();

    const form = document.querySelector("#modal form");
    if (form) {
      form.submit();
    }
  }

  // Handle the click event on the "Cancel" link
  close(e) {
    e.preventDefault();

    const modalFrame = document.getElementById("modal");
    modalFrame.innerHTML = "";
  }
}
