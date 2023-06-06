// app/javascript/controllers/insert-in-list_controller.js
import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["descriptions"];

  loadData() {
    const results = this.descriptionsTarget;
    const wordTitle = document.querySelector('input[name="word[title]"]').value;

    fetch(`https://api.dictionaryapi.dev/api/v2/entries/en/${wordTitle}`)
      .then(response => response.json())
      .then((data) => {
        const wordDescription = data[0].meanings[0].definitions[0].definition;
        const wordTag = `<li class="list-inline-item">
          <p>${wordTitle}</p>
          <p>${wordDescription}</p>
        </li>`;
        results.insertAdjacentHTML("beforeend", wordTag);

      });
  }
}
