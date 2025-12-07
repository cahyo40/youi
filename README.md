# 🎨 YoUI - Flutter Style Guide & Component Library

[![Flutter](https://img.shields.io/badge/Flutter-3.0+-02569B?logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.0+-0175C2?logo=dart)](https://dart.dev)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![pub package](https://img.shields.io/badge/pub-v1.0.3-blue)](https://github.com/cahyo40/youi)

A comprehensive, production-ready Flutter UI library with **60+ components**, **30 color schemes**, and a complete design system for building beautiful, consistent applications.

## ✨ Features

| Feature | Description |
|---------|-------------|
| 🎯 **Design System** | Unified colors, typography, and spacing |
| 🎨 **30 Color Schemes** | Industry-specific themes (Tech, Healthcare, Finance, etc.) |
| 🌓 **Theme Support** | Light & dark mode with easy customization |
| 📱 **Responsive** | Adaptive layouts for mobile, tablet, desktop |
| 🧩 **60+ Components** | Buttons, Cards, Dialogs, Forms, Navigation, and more |
| 🛠️ **Utilities** | Date formatting, ID generation, logging, connectivity |

## 📦 Installation

```yaml
dependencies:
  yo_ui:
    git:
      url: https://github.com/cahyo40/youi.git
      ref: main
```

```bash
flutter pub get
```

## 🚀 Quick Start

### 1. Apply Theme

```dart
import 'package:yo_ui/yo_ui.dart';

MaterialApp(
  theme: YoTheme.lightTheme(context),
  darkTheme: YoTheme.darkTheme(context),
  // Or use a specific color scheme:
  // theme: YoTheme.lightTheme(context, YoColorScheme.techPurple),
)
```

### 2. Use Components

```dart
Scaffold(
  body: Column(
    children: [
      YoText.headlineMedium('Welcome to YoUI'),
      YoButton.primary(
        text: 'Get Started',
        onPressed: () {},
      ),
      YoCard(
        child: YoText.bodyMedium('Beautiful components'),
      ),
    ],
  ),
)
```

## 🎨 Color Schemes

Choose from 30 industry-specific color schemes:

| Category | Schemes |
|----------|---------|
| **Tech** | `techPurple`, `codingDark`, `cryptoModern` |
| **Healthcare** | `oceanTeal`, `healthcarePro`, `wellnessMint` |
| **Business** | `corporateModern`, `realEstatePro`, `startupVibrant` |
| **Lifestyle** | `foodAmber`, `travelCoral`, `fitnessEnergy` |
| **Creative** | `creativeMagenta`, `musicVibes`, `artGallery` |
| **Entertainment** | `gamingNeon`, `kidsLearning`, `energyRed` |

```dart
// Apply a specific scheme
YoTheme.lightTheme(context, YoColorScheme.techPurple)
```

## 🧩 Components

### Typography

```dart
YoText.displayLarge('Display')
YoText.headlineMedium('Headline')
YoText.bodyMedium('Body text')
YoText.monoLarge('Rp 1.000.000')  // Monospace for numbers
```

### Buttons

```dart
YoButton.primary(text: 'Primary', onPressed: () {})
YoButton.secondary(text: 'Secondary', onPressed: () {})
YoButton.outline(text: 'Outline', onPressed: () {})
YoButton.ghost(text: 'Ghost', onPressed: () {})

// With loading state
YoButton.primary(text: 'Loading...', isLoading: true, onPressed: () {})
```

### Feedback

```dart
// Loading
YoLoading.spinner()
YoLoading.dots()

// Skeleton
YoSkeleton.line(width: 200)
YoSkeleton.circle(size: 50)

// States
YoEmptyState.noData(title: 'No data', onAction: () {})
YoErrorState(error: 'Error message', onRetry: () {})
```

### Dialogs & Sheets

```dart
// Dialog
YoDialog.show(context: context, title: 'Title', content: 'Message');

// Confirm dialog
YoConfirmDialog.show(
  context: context,
  title: 'Delete?',
  isDestructive: true,
);

// Bottom sheet
YoBottomSheet.show(context: context, child: YourWidget());
```

## 🛠️ Utilities

### Date Formatting

```dart
YoDateFormatter.formatDate(DateTime.now())       // '07 Dec 2024'
YoDateFormatter.formatRelativeTime(date)         // '2 hours ago'
YoDateFormatter.isToday(date)                    // true/false
```

### ID Generation

```dart
YoIdGenerator.uuid()                    // UUID v4
YoIdGenerator.numericId(length: 8)      // '12345678'
YoIdGenerator.userId()                  // 'USR_aB3xY8pQ'
```

### Connectivity

```dart
await YoConnectivity.initialize();
bool isOnline = YoConnectivity.isConnected;

YoConnectivity.addListener((connected) {
  // Handle connection changes
});
```

## 📐 Responsive Design

```dart
// Check device type
if (YoResponsive.isMobile(context)) { }
if (YoResponsive.isTablet(context)) { }
if (YoResponsive.isDesktop(context)) { }

// Responsive values
YoResponsive.responsiveValue(
  context,
  mobile: 16.0,
  tablet: 24.0,
  desktop: 32.0,
)
```

## 📏 Spacing & Padding

```dart
// Predefined padding
Padding(padding: YoPadding.all16, child: ...)
Container(margin: YoPadding.symmetricV8, ...)

// Spacing constants
SizedBox(height: YoSpacing.md)  // 16
SizedBox(width: YoSpacing.lg)   // 24
```

## 🔧 Context Extensions

```dart
// Text styles
context.yoHeadlineLarge
context.yoBodyMedium

// Screen info
context.yoScreenWidth
context.yoIsMobile
context.yoIsTablet
```

## 📚 Dependencies

| Package | Purpose |
|---------|---------|
| `google_fonts` | Typography |
| `cached_network_image` | Image caching |
| `connectivity_plus` | Network state |
| `device_info_plus` | Device information |
| `intl` | Date/number formatting |
| `photo_view` | Image viewer |

## 📄 License

MIT License - see [LICENSE](LICENSE) for details.

---

**Built with ❤️ for the Flutter community**
