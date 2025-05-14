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

## 🔍 SearchBar

I implemented a `UISearchController` because it's the easiest way to add a searchbar without having to worry about logic nor constraints. 
For the implementation I `DispatchWorkItem` which I had never used before to allow some buffer between the user input and actually doing the search. This way we avoid multiple updates to the view, multiple calls to the API and, in general, a bad experience for the user and the server.
I put a delay of 0.5 because it allows some margin for the user to write but not too long that the user has to wait after finishing.

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

## 🧙‍♂️ Extra Feature

I've added search by url to products related to the character. This could be expanded when adding comics, series or stories to the view. This could work as an MVP.
I thought about adding the covers from the comics instead of just adding a text but that would be moving goalposts in my opinion.

## 🐛 Debug

There are some issues which I think are derivative of the API not working properly. Sometimes the view stays white while loading content, this is because there's no response from the call yet. You can wait or you can try to take an action to make another call like writing on the searchbar for the listing or navigating back and forth from the detail to the list.
