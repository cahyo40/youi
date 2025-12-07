# 🎨 YoUI - Flutter UI Component Library

[![Flutter](https://img.shields.io/badge/Flutter-3.19+-02569B?logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.5+-0175C2?logo=dart)](https://dart.dev)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![pub package](https://img.shields.io/badge/pub-v1.1.0-blue)](https://github.com/cahyo40/youi)

A comprehensive, production-ready Flutter UI library with **70+ components**, **30 color schemes**, charts, and a complete design system for building beautiful, consistent applications.

## ✨ Features

| Feature | Description |
|---------|-------------|
| 🎯 **Design System** | Unified colors, typography, spacing, and shadows |
| 🎨 **30 Color Schemes** | Industry-specific themes (Tech, Healthcare, Finance, etc.) |
| 🌓 **Theme Support** | Light & dark mode with easy customization |
| 📱 **Responsive** | Adaptive layouts for mobile, tablet, desktop |
| 🧩 **70+ Components** | Buttons, Cards, Dialogs, Forms, Navigation, Charts, and more |
| 📊 **Charts** | Line, Bar, Pie/Donut charts with fl_chart |
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

## 🧩 Components

### Display Cards

```dart
// Product Card (E-commerce & POS)
YoProductCard(
  imageUrl: 'https://...',
  title: 'Product Name',
  price: 99.99,
  stock: 15,
  onEdit: () {},
  onDelete: () {},
)

// Destination Card (Travel)
YoDestinationCard.featured(
  imageUrl: 'https://...',
  title: 'Bali, Indonesia',
  location: 'Southeast Asia',
  rating: 4.8,
  price: 1200,
)

// Profile Card (Social)
YoProfileCard.cover(
  avatarUrl: 'https://...',
  name: 'John Doe',
  stats: [YoProfileStat(value: '1.2K', label: 'Followers')],
)

// Article Card (Blog/News)
YoArticleCard.featured(
  imageUrl: 'https://...',
  title: 'Article Title',
  category: 'Technology',
  readTime: 5,
)
```

### Charts (fl_chart)

```dart
// Line Chart
YoLineChart.simple(
  data: [YoChartData(x: 1, y: 10), YoChartData(x: 2, y: 25)],
  title: 'Sales Trend',
  curved: true,
  filled: true,
)

// Bar Chart
YoBarChart(
  data: [
    YoChartData(x: 0, y: 100, label: 'Jan'),
    YoChartData(x: 1, y: 150, label: 'Feb'),
  ],
  title: 'Monthly Revenue',
)

// Pie/Donut Chart
YoPieChart.donut(
  data: [
    YoPieData(value: 35, label: 'Product A'),
    YoPieData(value: 25, label: 'Product B'),
  ],
  centerText: '60%',
)

// Sparkline (mini chart)
YoSparkLine(data: [10, 15, 8, 20, 18, 25])
```

### Navigation

```dart
// Bottom Navigation
YoBottomNav(
  currentIndex: 0,
  items: [
    YoBottomNavItem(icon: Icons.home, label: 'Home'),
    YoBottomNavItem(icon: Icons.search, label: 'Search'),
  ],
  onTap: (index) {},
)

// Sidebar
YoSidebar(
  items: [
    YoSidebarItem(icon: Icons.dashboard, label: 'Dashboard'),
    YoSidebarItem(icon: Icons.settings, label: 'Settings'),
  ],
)

// Drawer
YoDrawer(
  header: YoDrawerHeader(title: 'App Name', subtitle: 'user@email.com'),
  items: [
    YoDrawerItem(icon: Icons.home, title: 'Home'),
    YoDrawerItem.divider(),
    YoDrawerItem.header('Settings'),
  ],
  footer: YoDrawerFooter(text: 'Made with YoUI', version: '1.1.0'),
)
```

### Forms

```dart
// Dropdown with validation
YoDropDown<String>(
  value: selectedValue,
  labelText: 'Category',
  hintText: 'Select category',
  isRequired: true,
  errorText: hasError ? 'Required field' : null,
  items: [
    YoDropDownItem(value: 'tech', label: 'Technology'),
    YoDropDownItem(value: 'health', label: 'Healthcare'),
  ],
  onChanged: (value) {},
)
```

### Feedback

```dart
// Dialogs
YoDialog.show(context: context, title: 'Title', content: 'Message');
YoConfirmDialog.showDestructive(context: context, title: 'Delete?');
YoBottomSheet.showList(context: context, items: [...]);

// Loading
YoLoading.spinner()
YoLoading.dots()
YoLoadingOverlay.showWhile(context: context, task: () async {});

// States
YoEmptyState.noData(title: 'No data', onAction: () {})
YoEmptyState.error(error: exception, onRetry: () {})
```

### Timeline

```dart
YoTimeline(
  events: [
    YoTimelineEvent(
      title: 'Order Placed',
      description: 'Your order has been confirmed',
      date: DateTime.now(),
      isCompleted: true,
    ),
    YoTimelineEvent(
      title: 'Processing',
      isActive: true,
    ),
  ],
)

// Stepper style
YoTimeline.stepper(events: [...], currentStep: 1)
```

## 📐 Adaptive Design

```dart
// Check device type
if (YoAdaptive.isMobile(context)) { }
if (YoAdaptive.isTablet(context)) { }
if (YoAdaptive.isDesktop(context)) { }

// Responsive values
YoAdaptive.value(
  context,
  mobile: 16.0,
  tablet: 24.0,
  desktop: 32.0,
)

// Adaptive spacing
YoSpace.adaptiveMd(context)
YoPadding.page(context)
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

## 📚 Dependencies

| Package | Purpose |
|---------|---------|
| `google_fonts` | Typography |
| `cached_network_image` | Image caching |
| `connectivity_plus` | Network state |
| `device_info_plus` | Device information |
| `intl` | Date/number formatting |
| `photo_view` | Image viewer |
| `fl_chart` | Charts & graphs |

## 📄 License

MIT License - see [LICENSE](LICENSE) for details.

---

**Built with ❤️ for the Flutter community**
