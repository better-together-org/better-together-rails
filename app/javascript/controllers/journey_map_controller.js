import { Controller } from "@hotwired/stimulus"
import { Turbo } from "@hotwired/turbo-rails"

// Defines a Stimulus controller for managing PersonCommunityMembership entities
export default class extends Controller {
  // Targets that the controller interacts with
  static targets = ['pages', 'partners', 'resources']

  // Lifecycle method called when the controller is connected to the DOM
  connect() {
    console.log("JourneyMap controller connected");
  }

  // Event handler for form submission
  loadContent(event) {
    event.preventDefault(); // Prevents the default form submission behavior
    event.stopImmediatePropagation()
    const url = event.currentTarget.href; // Retrieves the link url

    // Sends the form data to the server using fetch API
    fetch(url, {
      method: 'get',
      headers: {
        "Accept": "text/vnd.turbo-stream.html", // Specifies that Turbo Streams are expected in response
      }
    }).then(response => {
      if (response.ok) {
        return response.text(); // Returns response text if the fetch was successful
      } else {
        throw new Error('Network response was not ok', response);
      }
    }).then(html => {
      Turbo.renderStreamMessage(html); // Renders the Turbo Stream update to the DOM
    }).catch(error => {
      console.error("Failed to submit:", error); // Logs any errors to the console
    });
  }
}
