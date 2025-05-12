# WallaMarvel - Raúl's Version

## 🏗 Architecture

There's not much to highlight here—I followed the architecture used in the listing.  
For a larger project, I would have likely introduced a `Navigator` class and applied **Service Locator** patterns to manage dependency initialization more cleanly and scalably.

## 🎨 UI

The UI is built using **stack views** to simplify layout management and ensure better scalability.  
Constraints are minimal—just enough to respect the safe area and fix the image size.

## 🌐 Networking

I implemented the expected API calls, but unfortunately, the **Marvel API never worked** for me during development.  
As a fallback, I included **local JSON files** to simulate the API responses if the network call fails.

I chose **Hulk** as the primary character for real API calls simply out of personal preference—he's a more complete example, with the API returning more data. If the app were to display every value from the response, Hulk provides one of the most detailed entries.

## ✅ Testing

### 🧪 Unit Testing

- Added a unit test to verify that the use case correctly passes data to the adapter in the list.

### 🧪 UI Testing

- Created a UI test that:
  - Taps a cell in the list.
  - Verifies navigation to the detail screen.
  - Confirms that the hero's description is displayed.

This test ensures:
- The list has cells.
- Cells are tappable.
- Navigation works correctly.
- The detail view shows the correct data.

### 🧪 Mocks

- Built custom mocks for unit tests to avoid turning them into integration tests, as that would be redundant with the UI test.
- For UI tests, I created a `MockApiClient`:
  - Avoids using real network calls (which would cause flakiness, waste credits from the API, and complicate CI/CD).
  - In these tests, I used **A-Bomb (HAS)** instead of Hulk in the detail view, since he's the first character in the list with a description. This creates a more realistic test by ensuring the detail view matches the tapped cell—just as it would in a functioning app.
