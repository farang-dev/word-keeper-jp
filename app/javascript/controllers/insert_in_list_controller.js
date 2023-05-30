send(event) {
  event.preventDefault();

  const wordTitle = this.formTarget.querySelector('input[name="word[title]"]').value;
  const wordDescription = this.formTarget.querySelector('input[name="word[description]"]').value;

  // Make the API request to retrieve the definition here

  const formData = new FormData();
  formData.append("word[title]", wordTitle);
  formData.append("word[description]", wordDescription);

  fetch(this.formTarget.action, {
    method: "POST",
    headers: { "Accept": "application/json" },
    body: new FormData(this.formTarget)
  })
  .then(response => response.json())
  .then((data) => {
    if (data.inserted_item) {
      this.itemsTarget.insertAdjacentHTML("beforeend", data.inserted_item)
    }
    this.formTarget.outerHTML = data.form
  })

    deleteWord(event) {
      event.preventDefault();
      const wordElement = event.currentTarget.closest("[data-controller='insert-in-list']");
      const wordId = wordElement.dataset.wordId;

      fetch(`/words/${wordId}`, { method: "DELETE" })
        .then(() => {
          wordElement.remove();
        })
        .catch(error => {
          console.error(error);
        });
    }
}
