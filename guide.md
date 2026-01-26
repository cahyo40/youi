# YoUI Complete Guide

Selamat datang di **YoUI** - *Advanced Flutter UI Framework* yang dirancang untuk membangun aplikasi cantik, responsif, dan konsisten dalam waktu singkat.

---

## Instalasi

Tambahkan package ke dalam `pubspec.yaml`:

```yaml
dependencies:
  yo_ui:
    git:
      url: https://github.com/cahyo40/youi.git
      ref: main
```

Jalankan:
```bash
flutter pub get
```

---

## Quick Start

### 1. Setup Theme

```dart
import 'package:yo_ui/yo_ui.dart';

void main() {
  // Opsional: Set custom fonts
  YoTextTheme.setFont(
    primary: YoFonts.poppins,
    secondary: YoFonts.inter,
    mono: YoFonts.spaceMono,
  );
  
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

### 2. Use Components

```dart
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return YoScaffold(
      appBar: YoAppBar(title: 'Dashboard'),
      body: Padding(
        padding: context.adaptivePagePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            YoText.headlineMedium('Welcome Back!'),
            YoSpace.heightMd(),
            YoCard(
              child: YoListTile(
                leading: YoAvatar.image(imageUrl: 'https://...'),
                title: 'John Doe',
                subtitle: 'Flutter Developer',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

### 3. Use Context Extensions

```dart
// Colors
Color primary = context.primaryColor;
Color error = context.errorColor;

// Typography
TextStyle title = context.yoTitleLarge;

// Responsive
bool mobile = context.isMobile;
double spacing = context.adaptiveMd;
EdgeInsets padding = context.adaptivePagePadding;
```

---

## Documentation

Dokumentasi YoUI dipisahkan menjadi beberapa kategori utama:

### [Components Guide](./COMPONENTS.md)

Katalog lengkap **80+ widget** siap pakai:

| Category | Count | Examples |
|----------|-------|----------|
| Display | 23 | YoAvatar, YoChart, YoTimeline, YoKanban, YoCarousel |
| Form | 12 | YoTextFormField, YoDropDown, YoOtpField, YoChipInput |
| Feedback | 18 | YoToast, YoDialog, YoLoading, YoSkeleton, YoEmptyState |
| Navigation | 8 | YoAppBar, YoBottomNav, YoSidebar, YoStepper, YoTabBar |
| Picker | 11 | YoDatePicker, YoColorPicker, YoFilePicker, YoImagePicker |
| Layout | 4 | YoGrid, YoMasonryGrid, YoSpace |
| Utility | 4 | YoInfiniteScroll, YoResponsiveBuilder |

### [Themes & Design System](./THEMES.md)

Sistem desain lengkap:

- **36+ Color Schemes** - Preset warna untuk berbagai industri
- **51+ Google Fonts** - Font typography terintegrasi
- **Adaptive Layout** - Responsive breakpoints & spacing
- **30+ Shadow Presets** - YoBoxShadow untuk elevasi
- **Context Extensions** - Shortcut untuk colors, typography, responsive

### [Helpers & Utilities](./HELPERS.md)

Utility untuk logika aplikasi:

- **YoCurrencyFormatter** - Format Rupiah & currencies
- **YoDateFormatter** - Format & manipulasi tanggal
- **YoStringFormatter** - Manipulasi string
- **YoIdGenerator** - Generate ID offline
- **Text Input Formatters** - Format input (currency, phone, credit card)
- **YoDeviceHelper** - Info perangkat
- **YoConnectivity** - Monitor koneksi internet
- **YoLogger** - Debug logging berwarna

---

## Package Structure

```
lib/src/
├── colors/         # Color system & schemes (36+ presets)
├── themes/         # Theme components & shadows
├── fonts/          # Google Fonts integration (51+)
├── layout/         # Responsive & adaptive spacing
├── extensions/     # Context extensions (shortcuts)
├── helpers/        # Formatters, generators, utilities
│   ├── formatters/   # Currency, Date, String
│   ├── generators/   # ID generators
│   ├── devices/      # Device info
│   ├── network/      # Connectivity
│   └── development/  # Logger
└── components/     # UI Widget collection (80+)
    ├── basic/        # Button, Card, Scaffold
    ├── display/      # Avatar, Chart, Timeline, Cards
    ├── form/         # Input fields, Dropdown, OTP
    ├── feedback/     # Toast, Dialog, Loading, Skeleton
    ├── navigation/   # AppBar, BottomNav, Sidebar
    ├── picker/       # Date, Color, File pickers
    ├── layout/       # Grid, Space
    └── utility/      # InfiniteScroll, ResponsiveBuilder
```

---

## Feature Highlights

### Theming

```dart
// 36+ professional color schemes
YoTheme.lightTheme(context, YoColorScheme.techPurple);
YoTheme.darkTheme(context, YoColorScheme.amoledBlack);

// Custom palette
setCustomPalette(light: lightPalette, dark: darkPalette);
```

### Responsive Design

```dart
// Adaptive values
double spacing = context.adaptiveMd;          // 16/20/24
EdgeInsets padding = context.adaptivePagePadding;
int columns = context.adaptiveGridColumns;    // 2/3/4

// Device checks
if (context.isMobile) { ... }
if (context.isDesktop) { ... }
```

### Typography

```dart
// 51+ Google Fonts
YoTextTheme.setFont(primary: YoFonts.poppins);

// Text styles
Text('Title', style: context.yoTitleLarge);
YoText.headlineMedium('Headline');
```

### Shadows

```dart
Container(
  decoration: BoxDecoration(
    boxShadow: YoBoxShadow.soft(context),
  ),
)
```

### Formatters

```dart
// Currency
YoCurrencyFormatter.formatRupiahWithUnit(1500000);
// "Rp 1.5 Juta"

// Date
YoDateFormatter.formatRelativeTime(date);
// "5 menit lalu"

// ID
YoIdGenerator.orderId();
// "ORD_20260126847"
```

---

## Common Examples

### Form with Validation

```dart
YoForm(
  children: [
    YoTextFormField(
      labelText: 'Email',
      inputType: YoInputType.email,
      isRequired: true,
    ),
    YoTextFormField(
      labelText: 'Password',
      inputType: YoInputType.password,
      showVisibilityToggle: true,
    ),
    YoDropDown<String>(
      labelText: 'Role',
      value: selectedRole,
      items: [
        YoDropDownItem(value: 'admin', label: 'Admin'),
        YoDropDownItem(value: 'user', label: 'User'),
      ],
      onChanged: (v) => setState(() => selectedRole = v),
    ),
    YoButton(
      text: 'Submit',
      onPressed: () => submitForm(),
    ),
  ],
)
```

### Product Grid

```dart
YoGrid.responsive(
  context: context,
  phoneColumns: 2,
  tabletColumns: 3,
  desktopColumns: 4,
  children: products.map((p) => YoProductCard.grid(
    imageUrl: p.imageUrl,
    title: p.name,
    price: p.price,
    rating: p.rating,
    onAddToCart: () => addToCart(p),
  )).toList(),
)
```

### Loading States

```dart
// Skeleton loading
if (isLoading) {
  return YoSkeletonCard(hasImage: true, hasTitle: true);
}

// Loading overlay
YoLoadingOverlay(
  isLoading: isSubmitting,
  message: 'Saving...',
  child: FormContent(),
)

// Toast notifications
YoToast.success(context, 'Data saved!');
YoToast.error(context, 'Failed to save');
```

### Date & Time Pickers

```dart
YoDatePicker(
  labelText: 'Birth Date',
  selectedDate: birthDate,
  onDateChanged: (date) => setState(() => birthDate = date),
)

YoDateRangePicker(
  labelText: 'Trip Dates',
  selectedRange: tripDates,
  onRangeChanged: (range) => setState(() => tripDates = range),
)
```

---

## Requirements

- Flutter SDK >= 3.0.0
- Dart >= 3.0.0

## Dependencies

- google_fonts
- fl_chart
- connectivity_plus
- file_picker
- image_picker
- device_info_plus
- crypto

---

## Version

**YoUI Flutter Package v1.1.4**

---

*Build Beautiful Apps Faster*
