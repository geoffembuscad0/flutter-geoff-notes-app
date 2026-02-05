# 🚀 Flutter Starter Kit

Because why start from scratch when you can start with awesomeness? 🎯

A carefully crafted Flutter starter template that save you from the boring setup stuff. You know, the stuff that makes you go "ugh, not again!" 😫

# 🛠 Prerequisites

- Flutter SDK (we're rocking version 3.27.1 🎸)
- FVM (Flutter Version Management) - because we're fanc like that
- A cup of coffee ☕️ (or tea 🫖, we don't judge)

## 🚦 Getting Started

### Using FV (Recommended)

```bash
# Clone this bad boy
git clone https://github.com/yourusername/flutter_starter_kit.git
cd flutter_starter_kit
fvm use 3.27.1
fvm flutter pub get
```

### Without FVM

```bash
# Check your Flutter version
flutter --version

# If not on 3.27.1, upgrad Flutter
flutter upgrade

# Clone and setup
git clone https://github.com/yourusername/flutter_starter_kit.git
cd flutter_starter_kit
flutter pub get
```

## 🏗 Projec Structure

```
lib/
├── app/
│   ├── api_client/      # API communication wizardry
│   ├── config/          # App configuration spells
│   ├─ const/          # Constants (the boring but important stuff)
│   ├── enum/           # Enums (because we're organized!)
│   ├── providers/       State management magic
│   ├── routes/         # Navigation compass
│   ├── services/       # Business logic kingdom
│   └── utils/           Utility belt (Batman approved)
├── core/
│   ├── apis/           # API endpoints
│   ├── model/          # Data models (keepin it clean)
│   ├── notifiers/      # State notifications
│   └── services/       # Core services
└── presentation/
    ├── screens/        # UI screen
    └── widgets/        # Reusable widgets
```

## 📦 Dependencies

```yaml
dependencies:
  dio: ^5.7.0 # HTTP ninja
  provider: ^6.1.2 # State managemen guru
  go_router: ^14.6.2 # Navigation master
  connectivity_plus: ^6.1.1 # Internet detective
  shared_preferences: ^2.3.5 # Local data hoarder
  logger: ^2.5.0 # Debu whisperer
  flex_color_scheme: ^8.1.0 # Making things pretty
  json_annotation: ^4.9.0 # JSON wizard
  equatable: ^2.0.7 # Equality made easy
```

# 🏛 Architecture

This project uses a hybrid architecture combining aspects of MVC and Provider patterns for state management.

### 📱 Application Layers

#### 1. Presentation Layer (`lib/presentation/`)

- **Screens**: UI components and screen logic
- **Widgets**: Reusable UI components
- Each screen can have its own widgets folder

#### 2. State Management (`lib/core/notifiers/`)

- **Notifiers**: Provider state management classes
- **States**: Immutable state classes

Example:

```dart
core/notifiers/
├── auth/
│   ├── auth_notifier.dart    # Auth state logic
│   └── auth_state.dart       # Auth state model
└── theme/
    ├── theme_notifier.dart   # Theme state logic
    └── theme_state.dart      # Theme state model
```

#### 3. Data Layer (`lib/core/`)

- **APIs** (`apis/`): API endpoints and network calls
- **Models** (`model/`): Data models and serialization
- **Services** (`services/`): Business logic and services

### 🔄 State Management Flow

```
UI (Screen) → Notifier → State → UI Update
    ↑          ↓
    └── API Services
```

**Flow Details:**

- Screens dispatch actions to Notifiers
- Notifiers handle business logic and update States
- States are immutable and represent UI data
- Services handle external data operations

# 🎨 Features

- 🔐 Authentication ready
- 🌓 Dark/Light theme
- 🌐 API integration setup
- Responsive design
- 🔄 State management
- 📍 Navigation

## 🤝 Contributing

1. Fork it
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push t the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📝 License

MIT Licens - feel free to copy, steal, modify, or frame it on your wall!

## 🎉 Special Thanks

Thanks to coffe ☕️, Stack Overflow 🚀, and that one YouTube tutorial that finally made sense.

P.S. If this starter kit saved you hours of setup, consider:
- Giving the repo a ⭐️
- Sharing it with other Flutter devs 🫂
- Contributing back to the project 🤝

Made with ❤️ and probably too much ☕️
