import Sortable from "sortablejs"

const list = document.querySelector(".card")

const initSortable = () => {
  Sortable.create(list)
}

export { initSortable }
