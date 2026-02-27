# DreamHunter

DreamHunter is an interactive 2D RPG/Adventure game developed using the **Flutter** framework and the **Flame** engine. It features dynamic gameplay elements, integrated user authentication, and persistent cloud storage.

## ✨ Features

- **2D Game World:** Built using the `Flame` engine for high-performance graphics and animations.
- **User Authentication:** Secure email/password login and registration powered by **Firebase Authentication**.
- **Unique Player IDs:** Each user is assigned a unique, sequential player number (e.g., Player #1, Player #2).
- **Persistent Progress:** Game data and user profiles are stored in **Cloud Firestore**.
- **Modern UI:** Features a liquid-glass aesthetic for menus and dialogs.

## 🛠️ Tech Stack

- **Framework:** [Flutter](https://flutter.dev/)
- **Game Engine:** [Flame](https://flame-engine.org/)
- **Backend:** [Firebase Authentication](https://firebase.google.com/products/auth), [Cloud Firestore](https://firebase.google.com/products/firestore)

## 🚀 Getting Started

1. **Clone the repository:**
   ```bash
   git clone https://github.com/ractopen/DreamHunter.git
   ```

2. **Install dependencies:**
   ```bash
   cd frontend
   flutter pub get
   ```

3. **Configure Firebase:**
   Ensure you have your `google-services.json` (Android) and `GoogleService-Info.plist` (iOS) in the appropriate directories.

4. **Run the app:**
   ```bash
   flutter run
   ```

## 🏗️ Project Structure

- `frontend/lib/presentation`: UI screens and custom widgets.
- `frontend/lib/domain/game`: Game logic and world-building components.
- `frontend/assets`: Visual and audio assets.

---
Developed as a school project.
