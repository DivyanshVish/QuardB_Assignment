
# NetMirror App

A simple Flutter app that allows users to search and view movie details using the TVMaze API.

## Features

- **Splash Screen**: Displays an introductory screen with a theme-related image.
- **Home Screen**: Displays a list of movies fetched from the API with thumbnails, titles, and summaries. Click on a movie to view its details.
- **Search Screen**: Users can search for movies by title using a search bar. Results are displayed similarly to the home screen.
- **Details Screen**: Shows detailed information about a movie including its image, summary, and title.
- **Bottom Navigation**: Switch between Home and Profile screens using the bottom navigation bar.

## API Endpoints Used

1. **Home Screen**:
   - Endpoint: `https://api.tvmaze.com/search/shows?q=all`
   - Retrieves a list of movies to display on the Home Screen.

2. **Search Screen**:
   - Endpoint: `https://api.tvmaze.com/search/shows?q={search_term}`
   - Searches for movies based on the user's input.

## Screens Overview

### 1. Splash Screen

Displays an introductory screen with a theme-related image for a few seconds before transitioning to the Home screen.

### 2. Home Screen

- Displays a list of movies with:
  - Image thumbnail
  - Movie title
  - Short summary
- Tapping on a movie navigates to the Details screen.

### 3. Search Screen

- Allows users to search for movies using a search bar.
- Displays results in the same format as the Home screen.

### 4. Details Screen

- Shows the detailed information of the movie selected from the Home or Search screens, including:
  - Image
  - Title
  - Summary

### 5. Profile Screen

- Shows the detailed information of User
  - Image
  - Title
  - Setting

## Installation

### Prerequisites

- Flutter SDK (version 2.x or higher)
- Dart SDK (comes with Flutter)

### 1. Clone the Repository

```bash
git clone https://github.com/DivyanshVish/QuardB_Assignment
```

### 2. Install Dependencies

In the project root directory, run the following command to install dependencies:

```bash
flutter pub get
```

### 3. Run the App

To run the app, use the following command:

```bash
flutter run
```

## Directory Structure

```plaintext
lib/
├── main.dart            # Entry point of the app
├── splash_screen.dart   # Splash Screen Widget
├── home_screen.dart     # Home Screen Widget
├── search_screen.dart   # Search Screen Widget
├── details_screen.dart  # Movie Details Screen Widget
├── profile_screen.dart  # Profile Detail Screen Widget

```

## Author

- **Divyansh Vishwakarma**
- **GitHub Profile**: [https://github.com/DivyanshVish]

## APK Download

You can download the APK of the app from the following link:

- [Download APK](<https://drive.google.com/file/d/10O8rekIRX5t6l8s86rTCIfTQCTZu_lNe/view?usp=drive_link>)

Make sure to enable "Install from Unknown Sources" in your Android settings if you're installing the APK manually.
