import Sortable from "sortablejs"

const list = document.querySelectorAll(".card")

const initSortable = () => {
  Sortable.create(list)
}

export { initSortable }
