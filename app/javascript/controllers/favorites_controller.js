import { Controller } from "@hotwired/stimulus";
import axios from "axios";

export default class extends Controller {
  HEADERS = { ACCEPT: "application/json" };

  mark(e) {
    e.preventDefault();
    
    if (this.element.dataset.loggedInUser === "false") {
      Turbo.visit("/users/sign_in");
    }

    if (this.element.dataset.marked === "true") {
      this.unfavorite();
    } else {
      this.favorite();
    }
  }

  getFavoritePath() {
    return "/api/favorites";
  }

  getUnfavoritePath(favoriteId) {
    return `/api/favorites/${favoriteId}`;
  }

  favorite() {
    axios
      .post(
        this.getFavoritePath(),
        {
          user_id: this.element.dataset.userId,
          property_id: this.element.dataset.propertyId,
        },
        {
          headers: this.HEADERS,
        }
      )
      .then((response) => {
        this.element.dataset.marked = "true";
        this.element.dataset.favoriteId = response.data.id;
        this.element.setAttribute("fill", this.element.dataset.markedColor);
      });
  }

  unfavorite() {
    axios
      .delete(this.getUnfavoritePath(this.element.dataset.favoriteId), {
        headers: this.HEADERS,
      })
      .then((response) => {
        this.element.dataset.marked = "false";
        this.element.dataset.favoriteId = "";
        this.element.setAttribute("fill", this.element.dataset.unmarkedColor);
      });
  }
}
