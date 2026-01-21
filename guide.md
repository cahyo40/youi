# 📚 YoUI Complete Guide

Panduan lengkap untuk menggunakan semua fitur YoUI package.

---

## 📦 Instalasi

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

---

## 🚀 Quick Start

```dart
import 'package:yo_ui/yo_ui.dart';

void main() {
  // Optional: Set custom font
  YoTextTheme.setFont(primary: YoFonts.poppins);
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: YoTheme.lightTheme(context, YoColorScheme.techPurple),
      darkTheme: YoTheme.darkTheme(context, YoColorScheme.techPurple),
      themeMode: ThemeMode.system,
      home: HomePage(),
    );
  }
}
```

---

## 📁 Struktur Package

```
lib/
├── yo_ui.dart           # Entry point utama
├── yo_ui_base.dart      # Base exports
└── src/
    ├── colors/          # Color system
    ├── themes/          # Theme system  
    ├── fonts/           # Font registry (51 fonts)
    ├── layout/          # Responsive/adaptive system
    ├── extensions/      # Context extensions
    ├── helpers/         # Formatters, generators, utilities
    └── components/
        ├── basic/       # Button, Card, FAB, etc.
        ├── display/     # Avatar, Badge, Chart, etc.
        ├── feedback/    # Toast, Dialog, Loading, etc.
        ├── form/        # TextFormField, Dropdown, etc.
        ├── layout/      # Space, Grid
        ├── navigation/  # BottomNav, Drawer, etc.
        ├── picker/      # Date, Color, File picker, etc.
        └── utility/     # Animated, Infinite scroll
```

---

## 🎨 Color System

### YoColors (via Context)

```dart
// Primary colors
context.primaryColor;
context.secondaryColor;
context.accentColor;
context.textColor;
context.backgroundColor;

// Semantic colors
context.successColor;
context.warningColor;
context.errorColor;
context.infoColor;

// Gray scale (gray50 - gray900)
context.gray500;

// Gradients
context.primaryGradient;
context.accentGradient;
```

### Color Schemes (36+ preset)

```dart
YoColorScheme.defaultScheme   // Finance
YoColorScheme.techPurple      // Tech
YoColorScheme.oceanTeal       // Healthcare
YoColorScheme.gamingNeon      // Gaming
YoColorScheme.amoledBlack     // AMOLED Dark
YoColorScheme.custom          // Custom palette
```

### Custom Palette

```dart
setCustomPalette(
  light: YoCorePalette(
    text: Color(0xFF1A1A2E),
    background: Color(0xFFFAFAFF),
    primary: Color(0xFF6C63FF),
    secondary: Color(0xFF9D4EDD),
    accent: Color(0xFF00D9A5),
  ),
  dark: YoCorePalette(...),
);
```

---

## 📝 Typography

```dart
// Setup font
YoTextTheme.setFont(
  primary: YoFonts.poppins,    // Headlines
  secondary: YoFonts.inter,    // Body
  mono: YoFonts.spaceMono,     // Code
);

// Text styles via context
context.yoDisplayLarge;
context.yoHeadlineMedium;
context.yoTitleLarge;
context.yoBodyMedium;
context.yoLabelSmall;
context.yoCurrencyMedium;
```

---

## 🌑 Shadow System

```dart
YoBoxShadow.soft(context);       // Card/tile
YoBoxShadow.elevated(context);   // Elevated
YoBoxShadow.float(context);      // FAB/modal
YoBoxShadow.neumorphic(context); // Neumorphic

// Size shortcuts
YoBoxShadow.sm(context);
YoBoxShadow.md(context);
YoBoxShadow.lg(context);

// Semantic
YoBoxShadow.success(context);
YoBoxShadow.error(context);
```

---

## 📐 Responsive/Adaptive

```dart
// Device type
context.isMobile;
context.isTablet;
context.isDesktop;

// Adaptive spacing
context.adaptiveSm;   // 4-8-12 (mobile/tablet/desktop)
context.adaptiveMd;   // 16-20-24
context.adaptiveLg;   // 24-32-40

// Adaptive padding
context.adaptivePagePadding;
context.adaptiveCardPadding;

// Conditional values
YoAdaptive.value(context, mobile: 14, tablet: 16, desktop: 18);
```

---

## 🔘 Components

### Basic Components

```dart
// Button variants
YoButton.primary(text: 'Submit', onPressed: () {});
YoButton.secondary(text: 'Cancel', onPressed: () {});
YoButton.outline(text: 'Details', onPressed: () {});
YoButton.ghost(text: 'Skip', onPressed: () {});

// Button styles: modern, minimalist, pill, sharp, rounded
YoButton.primary(text: 'Pill', onPressed: () {}, style: YoButtonStyle.pill);

// Card variants
YoCard(child: content);
YoCard.filled(child: content);
YoCard.elevated(child: content);
YoCard.outlined(child: content);

// FAB with speed dial
YoFAB.speedDial(
  icon: Icons.add,
  actions: [
    YoFABAction(icon: Icons.camera, label: 'Camera', onTap: () {}),
  ],
);

// Spacing
YoSpace.xs();  // 4px
YoSpace.md();  // 16px
YoSpace.adaptiveLg();  // Adaptive
```

### Display Components

```dart
// Avatar
YoAvatar.image(imageUrl: '...', size: YoAvatarSize.lg);
YoAvatar.text(text: 'John Doe');
YoAvatar.icon(icon: Icons.person, showBadge: true);

// Badge
YoBadge(text: 'New', variant: YoBadgeVariant.success);

// Rating
YoRating(value: 4.5, onChanged: (v) {});

// Expandable text
YoExpandableText(text: 'Long text...', maxLines: 3);

// Charts
YoChart.line(data: [...], labels: [...]);
YoChart.bar(data: [...], labels: [...]);
YoChart.pie(data: [...], labels: [...]);
```

### Form Components

```dart
// TextFormField with styles
YoTextFormField(
  controller: controller,
  labelText: 'Email',
  inputStyle: YoInputStyle.outlined, // outlined, filled, underline, modern
  inputType: YoInputType.email,
);

// Dropdown
YoDropDown<String>(
  label: 'Country',
  value: selected,
  items: [YoDropDownItem(value: 'id', label: 'Indonesia')],
  onChanged: (v) {},
);

// OTP Field
YoOtpField(length: 6, onCompleted: (pin) {});

// Search
YoSearchField(hintText: 'Search...', onChanged: (v) {});

// Chip Input
YoChipInput(chips: ['Flutter'], onChipsChanged: (chips) {});
```

### Feedback Components

```dart
// Toast
YoToast.success(context: context, message: 'Success!');
YoToast.error(context: context, message: 'Error occurred');

// Dialog
YoDialog.info(context: context, title: 'Info', message: 'Message');
YoDialog.success(context: context, title: 'Success', message: 'Done!');

// Confirm dialog
final confirmed = await YoConfirmDialog.show(
  context: context,
  title: 'Delete?',
  message: 'This cannot be undone.',
);

// Loading
YoLoading(type: YoLoadingType.spinner);
YoLoadingOverlay(isLoading: true, child: content);

// Progress
YoProgress(value: 0.65, showLabel: true);

// Shimmer/Skeleton
YoShimmer(child: Container());
YoSkeletonListTile();
YoSkeletonCard();
```

### Navigation Components

```dart
// Bottom Nav
YoBottomNavBar(
  currentIndex: index,
  items: [
    YoNavItem(icon: Icons.home, label: 'Home'),
    YoNavItem(icon: Icons.person, label: 'Profile', badge: '3'),
  ],
  onTap: (i) {},
);

// Drawer
YoDrawer(
  header: YoDrawerHeader(title: 'App'),
  items: [YoDrawerItem(icon: Icons.home, title: 'Home')],
);

// Stepper
YoStepper(
  currentStep: 0,
  steps: [YoStep(title: 'Step 1', content: Widget())],
  onStepContinue: () {},
);

// Pagination
YoPagination(currentPage: 1, totalPages: 10, onPageChanged: (p) {});
```

### Picker Components

```dart
// Date pickers
YoDatePicker(selectedDate: date, onDateChanged: (d) {});
YoDateRangePicker(selectedRange: range, onRangeChanged: (r) {});
YoTimePicker(selectedTime: time, onTimeChanged: (t) {});
YoMonthPicker(selectedRange: month, onMonthChanged: (r) {});

// Color picker
YoColorPicker(selectedColor: color, onColorSelected: (c) {});

// Icon picker
YoIconPicker(selectedIcon: icon, onIconSelected: (i) {});

// File/Image picker
YoFilePicker(onFilesPicked: (files) {});
YoImagePicker.showSourcePicker(context: context);
```

---

## 🛠 Helpers

### YoCurrencyFormatter

```dart
// Currency formatting
YoCurrencyFormatter.formatCurrency(1500000); // "Rp 1.500.000"
YoCurrencyFormatter.formatCurrency(1500, locale: 'en_US'); // "$1,500"

// Rupiah dengan satuan
YoCurrencyFormatter.formatRupiahWithUnit(1560000); // "Rp 1.56 Juta"
YoCurrencyFormatter.formatRupiahCompact(2500000);  // "Rp 2.5Jt"

// Number formatting
YoCurrencyFormatter.formatNumber(1000000);         // "1.000.000"
YoCurrencyFormatter.formatCompactNumber(1500000);  // "1.5M"
YoCurrencyFormatter.formatPercentage(0.85);        // "85%"

// Large numbers
YoCurrencyFormatter.formatVeryLargeNumber(1e18);   // "1 Quintiliun"
YoCurrencyFormatter.formatLargeNumberWithSymbol(1500000); // "1.5M"
```

### YoDateFormatter

```dart
// Basic formatting
YoDateFormatter.formatDate(date);                  // "21 Jan 2026"
YoDateFormatter.formatDateTime(date);              // "21 Jan 2026 18:20"
YoDateFormatter.formatTime(date);                  // "18:20"

// Relative time
YoDateFormatter.formatRelativeTime(date);          // "5 menit lalu"

// Date helpers
YoDateFormatter.isToday(date);
YoDateFormatter.isYesterday(date);
YoDateFormatter.isWeekend(date);

// Manipulation
YoDateFormatter.startOfMonth(date);
YoDateFormatter.endOfMonth(date);
YoDateFormatter.addDays(date, 7);
YoDateFormatter.daysBetween(start, end);

// Age
YoDateFormatter.calculateAge(birthDate);           // 25
YoDateFormatter.formatAge(birthDate);              // "25 tahun"

// Duration
YoDateFormatter.formatDuration(duration);          // "1 jam 30 menit"

// Localization
YoDateFormatter.texts = DateTexts.english;         // Switch to English
```

### YoStringFormatter

```dart
// Text formatting
YoStringFormatter.titleCase('hello world');           // "Hello World"
YoStringFormatter.camelCaseToTitle('helloWorld');     // "Hello World"

// Phone/Address
YoStringFormatter.formatPhoneNumber('08123456789');   // "0812-3456-789"
YoStringFormatter.formatAddress('Jalan Merdeka');     // "Jl. Merdeka"

// Names
YoStringFormatter.getInitials('John Doe');            // "JD"
YoStringFormatter.formatNameShort('John Michael');    // "John M."

// Privacy
YoStringFormatter.obscureEmail('user@mail.com');      // "us****@mail.com"
YoStringFormatter.obscurePhoneNumber('08123456789');  // "0812****789"

// Utilities
YoStringFormatter.truncateWithEllipsis(text, maxLength: 30);
YoStringFormatter.formatFileSize(1048576);            // "1 MB"
YoStringFormatter.wordCount(text);
```

### YoIdGenerator

```dart
// Basic IDs
YoIdGenerator.uuid();                          // "550e8400-e29b-41d4-a716-446655440000"
YoIdGenerator.numericId(length: 8);            // "12345678"
YoIdGenerator.alphanumericId(length: 12);      // "A1b2C3d4E5f6"

// Prefixed IDs
YoIdGenerator.userId();                        // "USR_8A2B4C6D"
YoIdGenerator.orderId();                       // "ORD_20260121001"
YoIdGenerator.transactionId();                 // "TRX_8A2B4C6D"
YoIdGenerator.productId();                     // "PROD_8A2B4C6D"

// Timestamp-based
YoIdGenerator.timestampId();                   // "21012026182000"
YoIdGenerator.timestampWithRandomId();         // "2601211820001234"

// Hash-based
YoIdGenerator.md5Id(input);
YoIdGenerator.sha256Id(input);
YoIdGenerator.shortHashId(input);              // 8 karakter

// Custom format
YoIdGenerator.licenseKeyId();                  // "A1B2-C3D4-E5F6-G7H8"
YoIdGenerator.couponCode(prefix: 'SALE');      // "SALE8A2B4C6D"

// Batch
YoIdGenerator.batchGenerate(count: 10, prefix: 'INV');
```

### YoDeviceHelper

```dart
// Device info
final info = await YoDeviceHelper.getDeviceInfo();
// {platform: 'Android', model: 'Pixel 5', version: '13', ...}

// Platform check
YoDeviceHelper.getPlatformType();              // PlatformType.android
YoDeviceHelper.isMobile;                       // true
YoDeviceHelper.isDesktop;                      // false

// Screen info
YoDeviceHelper.isLandscape(context);
YoDeviceHelper.getScreenSize(context);         // ScreenSize.small
YoDeviceHelper.getPixelRatio(context);

// Safe area
YoDeviceHelper.getSafeAreaPadding(context);
YoDeviceHelper.getStatusBarHeight(context);
YoDeviceHelper.hasNotch(context);

// Keyboard
YoDeviceHelper.isKeyboardVisible(context);
YoDeviceHelper.getKeyboardHeight(context);
```

### YoLogger

```dart
// Enable/disable
YoLogger.enable();
YoLogger.disable();
YoLogger.setLevel(YoLogLevel.warning);

// Logging
YoLogger.debug('Debug message', tag: 'API');
YoLogger.info('Info message');
YoLogger.warning('Warning message');
YoLogger.error('Error message', error: e, stackTrace: stack);
YoLogger.critical('Critical error');
```

### YoConnectivity

```dart
// Initialize (call once in main)
await YoConnectivity.initialize();

// Check status
YoConnectivity.isConnected;                    // true
YoConnectivity.connectionName;                 // "WiFi"

// Manual check
await YoConnectivity.checkConnection();

// Listen for changes
YoConnectivity.addListener((isConnected) {
  print('Connected: $isConnected');
});

// Ensure connection before API call
await YoConnectivity.ensureConnection(() async {
  return await api.fetchData();
});

// Cleanup
YoConnectivity.dispose();
```

---

## 🎯 Context Extensions Summary

```dart
// Colors
context.primaryColor;
context.successColor;
context.gray500;

// Typography
context.yoBodyMedium;
context.yoTitleLarge;

// Spacing
context.adaptiveMd;
context.yoSpacingMd;

// Device
context.isMobile;
context.width;
context.yoSafeArea;
context.yoKeyboardVisible;

// Responsive values
context.responsiveValue(phone: 14, tablet: 16, desktop: 18);
```

---

## 📋 Component Count

| Category | Count |
|----------|-------|
| Basic | 12 |
| Display | 23 |
| Feedback | 18 |
| Form | 13 |
| Layout | 3 |
| Navigation | 8 |
| Picker | 11 |
| Utility | 3 |
| **Total** | **91** |

---

*YoUI Flutter Package v1.1.4 - Complete Component Library* 🎨
