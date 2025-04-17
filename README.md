Aynaa
A cross‑platform Learning Management App built in Flutter, supporting Android, iOS, Web, macOS, Windows, and Linux 
GitHub
.

Table of Contents
Features

Architecture

Getting Started

Folder Structure

Contributing

License

Contact & Support

Acknowledgements

This README is organized following community best practices to help users navigate the project efficiently 
FreeCodeCamp
.

Features
The Features section highlights the key functionalities of the application to inform users at a glance 
UMA Technology
.

Multi‑Platform Deployment: Single Flutter codebase targeting mobile, web, and desktop 
Dart programming language
.

Role‑Based Navigation: Separate flows for Admin and Student with custom bottom navigation bars.

Real‑Time Sync: Lessons and updates streamed via Supabase channels.

Offline Persistence: Local caching with Hive and Isar for uninterrupted usage.

Media Support: PDF & video rendering, file uploads with resumable Tus protocol.

Localization: Arabic (DZ) and English (US) support out of the box.

Architecture
The Architecture section outlines the app’s structural design, showcasing modularity and maintainability 
Dart programming language
.

Clean Architecture: Separation into core and features modules with GetIt for dependency injection.

State Management: Reactive Bloc pattern (flutter_bloc) for clear business‑logic isolation.

Routing: GoRouter for declarative, guarded routes based on authentication and roles.

Theming: Material 3, seeded from a deep purple color scheme for consistent styling.

Getting Started
The Getting Started section guides users through installation and initial setup to run the app locally 
AppOverride
.

Prerequisites
Flutter SDK (>=3.x) installed and added to PATH 
DEV Community
.

A Supabase project with URL and anon key configured in .env.

Installation
bash
Copy
Edit
# Clone the repository
git clone https://github.com/mellatilaid/aynaa.git :contentReference[oaicite:7]{index=7}
cd aynaa

# Install dependencies
flutter pub get

# Copy and configure environment variables
cp var.env .env
# Update .env with your Supabase credentials
Running the App
bash
Copy
Edit
# Launch on the available device or emulator
flutter run
Folder Structure
A well‑defined folder structure makes the codebase easier to understand and maintain 
Archbee
.

bash
Copy
Edit
aynaa/
├── android/           # Android project files
├── ios/               # iOS project files
├── lib/
│   ├── core/          # Shared utilities & services
│   ├── features/      # Feature modules (auth, lessons, etc.)
│   ├── widgets/       # Reusable UI components
│   ├── main.dart      # App entry point
│   └── router.dart    # GoRouter configuration
├── test/              # Unit & widget tests
├── web/               # Web project files
├── macos/             # macOS project files
├── windows/           # Windows project files
└── pubspec.yaml       # Flutter dependencies
Contributing
Contributing guidelines encourage community involvement and standardize contributions 
GitHub
.

Fork the repository.

Create a feature branch: git checkout -b feature/YourFeature.

Commit your changes: git commit -m "Add: Your feature".

Push to your branch and open a Pull Request.

Please read CONTRIBUTING.md (coming soon) for code style and commit conventions.

License
This project is licensed under the MIT License. Including a clear license communicates terms and usage permissions for all users and contributors 
GitHub
.

Contact & Support
For questions or feedback, open an issue in this repository or reach out via email: mellatilaid@example.com. Contact information provides users a way to report issues and request features 
DhiWise
.

Acknowledgements
Acknowledgements credit the frameworks, libraries, and community articles that informed this project’s development 
GitHub
.

Flutter

Supabase

Flutter Bloc

GoRouter

Hive & Isar

SalomonBottomBar

Tus client

Thank you for exploring the Aynaa project; contributions and feedback are always welcome 
WIRED
.

Note: This app is currently incomplete, with additional features and UI/UX improvements planned for future updates.
