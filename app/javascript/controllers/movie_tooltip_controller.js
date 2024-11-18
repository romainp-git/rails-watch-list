import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["tooltip", "id", "title", "overview", "genres", "modal"];

  connect() {
    console.log("hello")
    this.timeoutId = null;
    const hasErrors = this.modalTarget.dataset.movieHasErrors === "true";

    if (hasErrors) {
      this.open();
    }
  }

  show(event) {
    clearTimeout(this.timeoutId);
    const card = event.currentTarget;

    this.titleTarget.textContent = card.dataset.title;
    this.overviewTarget.textContent = card.dataset.overview;
    this.genresTarget.textContent = card.dataset.genres;
    this.idTarget.value = card.dataset.id;

    const tooltip = this.tooltipTarget;
    const mouseX = event.clientX;
    const mouseY = event.clientY + window.scrollY;

    const tooltipWidth = tooltip.offsetWidth;
    const tooltipHeight = tooltip.offsetHeight;

    const isCloseToRight = mouseX + tooltipWidth > window.innerWidth;
    const isCloseToBottom = mouseY + tooltipHeight > window.innerHeight + window.scrollY;

    let adjustedX = isCloseToRight ? mouseX - tooltipWidth : mouseX;
    let adjustedY = isCloseToBottom ? mouseY - tooltipHeight : mouseY;

    tooltip.style.left = `${adjustedX}px`;
    tooltip.style.top = `${adjustedY}px`;

    tooltip.classList.remove("hidden");
  }

  hide() {
    this.timeoutId = setTimeout(() => {
      this.tooltipTarget.classList.add("hidden");
    }, 100);
  }

  keepVisible() {
    clearTimeout(this.timeoutId);
  }

  open() {
    this.modalTarget.classList.remove("hidden");
  }

  close() {
    this.modalTarget.classList.add("hidden");
  }

  addToList() {
    this.modalTarget.classList.add("hidden");
  }
}
