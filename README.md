# Final Android Project

<p align="center">
  <img src="https://github.com/user-attachments/assets/dc566ab0-fefd-4fbd-8ebb-76ea333f5d09" alt="final android project" width="300"/>
</p>
## Project Overview

**Final Android Project** is a Flutter mobile application that lets parents and children easily **browse, download, and read illustrated children's books** in either **PDF** or **Word** format.

### Key User Actions

1. Browse a grid of available books
2. Toggle between PDF or Word downloads
3. View detailed information for each book
4. Download the chosen file with a progress indicator
5. Open the file directly from the app, using word \ google drive

## Technology Stack

- **Framework**: Flutter
- **Database**: Firebase
- **File Downloads**: Dio (HTTP client for downloading books)
- **Local Storage**: path_provider + open_file
- **Programming Language**: Dart

## App Structure

```
lib/
 ├── main.dart              # App entry-point & Firebase init
 ├── firebase_options.dart  # Auto-generated Firebase config
 ├── file_type.dart         # Enum for PDF / Word
 └── screens/
     ├── home_page.dart           # Book grid & format toggle
     └── book_details_screen.dart # Book details + download / open
```

### Primary Routes

| Route | Screen | Purpose |
|-------|--------|---------|
| `/` | `HomePage` | Book grid, format switch |
| *push* | `BookDetailsScreen` | Cover, description, download / open |

## Features

- **Dynamic Book List** — Pulled from Firestore, rendered in a responsive 2-column grid
- **Format Toggle** — Animated switch for **PDF** / **Word**
- **Details View** — Cover image, description, chosen format tag, and download button
- **Progress Indicator** — Linear progress bar during file download via Dio
- **Offline Access** — Files saved to app docs folder and opened with the system viewer
- **Generic Book Details Screen** — Reusable screen component that adapts for both PDF and Word formats with pre-loaded content
## Getting Started


> **Note:** When running on an emulator, you'll need to pre-install a Word reader app to view Word documents. On physical devices, Word files will open with the device's default document viewer.

## Screenshots

Here are some screenshots of our application:

1. **Home Page (Grid)**
   <p align="center">
  <img src="https://github.com/user-attachments/assets/dc566ab0-fefd-4fbd-8ebb-76ea333f5d09" alt="final android project" width="300"/>
   </p>

2. **Format Toggle Activated**
   <p align="center">
     <img src="https://github.com/user-attachments/assets/00702a7c-88b3-4362-ad9c-4d98e77e48e5" alt="final android project" width="300"/>
   </p>
3. **Book Details Screen**
   <p align="center">
     <img src="https://github.com/user-attachments/assets/55efe4f7-78bc-4d58-b8f9-00a05b1ad88d" alt="final android project" width="300"/>
   </p>
4. **Download in Progress**
   <p align="center">
     <img src="https://github.com/user-attachments/assets/9d7be82a-ffa6-4acb-8964-763bb52a8f96" alt="final android project" width="300"/>
   </p>
5. **File Opened Offline - word format**
   <p align="center">
     <img src="https://github.com/user-attachments/assets/7919d046-c7a5-40a2-81d6-2270dfabc6d6" alt="final android project" width="300"/>
   </p>
6. **File Opened Offline - pdf format**
   <p align="center">
     <img src="https://github.com/user-attachments/assets/1d659f6c-c47f-4cf8-9ab3-243e70048144" alt="final android project" width="300"/>
   </p>
## Project Outcomes

- Delivered a Flutter application with Firebase integration
- Implemented secure file downloads and offline viewing
- Practiced responsive UI design using Material 3
- Strengthened skills in asynchronous programming and state management in Dart
