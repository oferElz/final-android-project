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
     <img src="https://github.com/user-attachments/assets/505ed93b-c34e-4d40-bb82-cefeb68c4b61" alt="final android project" width="300"/>
   </p>

5. **Download finished, open button appear**
   <p align="center">
     <img src="https://github.com/user-attachments/assets/b92f7f00-183f-44af-aa7f-a51f7f6ef99c" width="300"/>
   </p>

6. **File Opened - word format**
   <p align="center">
     <img src="https://github.com/user-attachments/assets/c8f42a2c-167f-45fd-b996-29b2117ef319" alt="final android project" width="300"/>
   </p>

7. **File Opened - pdf format**
   <p align="center">
     <img src="https://github.com/user-attachments/assets/1f8b5825-fe7a-4e94-aaa9-f4848f6050f4" alt="final android project" width="300"/>
   </p>

## Project Outcomes

- Delivered a Flutter application with Firebase integration
- Implemented secure file downloads and offline viewing
- Practiced responsive UI design using Material 3
- Strengthened skills in asynchronous programming and state management in Dart
