# Application Architecture

This project follows a simple, layered architecture to keep code organized and maintainable. This approach separates the app into logical layers, making it easier to understand and work with.

## Directory Structure

The `lib` directory is organized into the following top-level folders:

```
lib/
├── data/           # For data-related classes (models from APIs, etc.)
│
├── domain/         # Your core game logic and objects (like the Player class)
│
├── presentation/   # All UI-related code (widgets, screens, and providers)
│
├── services/       # For shared services like checking online status
│
└── main.dart       # The entry point of the application
```

---

## Explanation of Layers

#### 1. `domain`

This is the center of your app. It holds your core game logic and rules.

*   **Example:** The `Player` class, which contains the data and logic for the player character, lives here.
*   **Rule:** Code in this layer should be "pure" and not depend directly on UI or external data sources.

#### 2. `presentation`

This layer contains everything related to the user interface (UI).

*   `screens/`: Each major screen of your app gets its own file here (e.g., `splash_screen.dart`, `main_screen.dart`).
*   `widgets/`: Smaller, reusable UI components that can be used across multiple screens.
*   `providers/`: State management classes. These classes hold the UI's state and connect the UI to the `domain` logic (e.g., `MessageProvider`).

#### 3. `data`

This layer is responsible for handling data from external sources, like a web API or a local database. For now, it is mostly a placeholder for future data models.

*   `models/`: Would contain classes that exactly match the structure of external data (e.g., from a JSON response).

#### 4. `services`

This folder holds classes that provide a specific service to the app, often across different parts of the code.

*   **Example:** `OnlineStatusService` continuously checks the network connection and provides this information to the UI.

---

### `main.dart`

The `main.dart` file is the entry point of the application. Its main responsibilities are:
*   Initializing necessary services.
*   Setting up top-level providers.
*   Running the root widget of the application.