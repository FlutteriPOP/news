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
- **Riverpod State Management** for reactive UI
- **Type Safety** with enums and strong typing
- **Error Handling** with Either pattern from Dartz
- **Modular Design** for easy maintenance and scaling

## Getting Started

### Prerequisites
- Flutter SDK (>=3.3.0)
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
│   ├── error/           # Error handling utilities
│   ├── network/        # Network client (Dio)
│   └── theme/          # App theming
├── features/
│   └── news/
│       ├── data/
│       │   ├── datasources/    # API data sources
│       │   ├── models/         # Data models
│       │   └── repository/    # Repository implementations
│       ├── domain/
│       │   ├── entities/       # Business entities
│       │   └── repositories/   # Repository interfaces
│       └── presentation/
│           ├── providers/      # Riverpod providers
│           ├── screens/        # UI screens
│           └── widgets/        # Reusable widgets
└── main.dart
```

## Key Dependencies

- **flutter_riverpod**: State management
- **dio**: HTTP client for API calls
- **google_fonts**: Typography
- **intl**: Date formatting
- **freezed**: Code generation for models
- **dartz**: Functional programming utilities

## API Integration

This app uses the official Hacker News API:
- Base URL: `https://hacker-news.firebaseio.com/v0/`
- Endpoints for different story types
- Real-time data fetching

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
