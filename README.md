# Whack - Hacker News Client

A modern, feature-rich Flutter application for browsing Hacker News stories with a beautiful UI and smooth user experience.

## Features

### 📱 **Navigation & Story Types**
- **Bottom Navigation Bar** with 6 different story categories:
  - 📈 Top Stories - Most popular stories
  - 🆕 New Stories - Latest submissions
  - ⭐ Best Stories - Highest quality content
  - ❓ Ask HN - Community questions
  - 👁️ Show HN - Project showcases
  - 💼 Jobs - Job postings

### 🔍 **Search Functionality**
- **Built-in Search** using Flutter's SearchDelegate
- Real-time search through story titles and authors
- Clean, intuitive search interface
- Instant results as you type

### 🎨 **Modern UI/UX**
- **Enhanced Story Cards** with:
  - Beautiful typography and spacing
  - Score badges with orange accent colors
  - Comment count badges
  - Smart time formatting (e.g., "2m ago", "3h ago", "Jan 15")
  - Smooth hover states and touch interactions
- **Material 3 Design** with proper theming
- **Dark/Light Mode** support following system preferences
- **Responsive Design** that works on all screen sizes

### ⚡ **Performance & Features**
- **Pull-to-Refresh** functionality
- **Infinite Scroll** with smart loading indicators
- **Error Handling** with retry buttons and clear error messages
- **Loading States** with descriptive feedback
- **Offline Support** considerations

### 🏗️ **Architecture**
- **Clean Architecture** with proper separation of concerns
- **GetX State Management** for reactive UI and dependency injection
- **Type Safety** with enums and strong typing
- **Error Handling** with proper error states and user feedback
- **Modular Design** for easy maintenance and scaling

## Getting Started

### Prerequisites
- Flutter SDK (>=3.11.0)
- Dart SDK compatible with Flutter version

### Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd whack
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

### Build for Production

```bash
# Android
flutter build apk

# iOS
flutter build ios

# Web
flutter build web
```

## Project Structure

```
lib/
├── core/
│   ├── controllers/     # Base controllers
│   ├── network/        # Network client (Dio)
│   ├── routes/         # App routing
│   ├── utils/          # Utility functions
│   └── widgets/        # Core widgets
├── features/
│   ├── comments/       # Comments feature
│   └── news/           # News feature
│       ├── controllers/    # News controllers
│       ├── models/         # Data models
│       ├── screens/        # UI screens
│       └── widgets/        # Feature widgets
└── main.dart
```

## Key Dependencies

- **get**: State management, dependency injection, and routing
- **dio**: HTTP client for API calls
- **shadcn_ui**: Modern UI components
- **flutter_html**: HTML rendering for story content
- **intl**: Date formatting
- **url_launcher**: Launch URLs in external apps
- **flutter_dotenv**: Environment variable management
- **json_annotation**: JSON serialization

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Run tests and ensure code quality
5. Submit a pull request

## License

This project is licensed under the MIT License.

---

Built with ❤️ using Flutter
