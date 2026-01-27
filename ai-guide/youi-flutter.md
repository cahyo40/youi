# YoUI Flutter Framework - AI Skill Guide

> **Framework**: YoUI v1.1.4
> **Purpose**: Advanced Flutter UI Framework for building beautiful, responsive, consistent apps
> **Trigger**: Use when developing Flutter applications with YoUI package

---

## QUICK REFERENCE

### Installation
```yaml
dependencies:
  yo_ui:
    git:
      url: https://github.com/cahyo40/youi.git
      ref: main
```

### Essential Setup (main.dart)
```dart
import 'package:yo_ui/yo_ui.dart';

void main() {
  // Optional: Set custom fonts
  YoTextTheme.setFont(
    primary: YoFonts.poppins,    // Headlines & Titles
    secondary: YoFonts.inter,    // Body & Labels
    mono: YoFonts.spaceMono,     // Numbers/Code
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

---

## CONTEXT EXTENSIONS (SHORTCUTS)

### Colors
```dart
context.primaryColor      // Primary brand color
context.secondaryColor    // Secondary color
context.accentColor       // Accent color
context.backgroundColor   // Background
context.textColor         // Text color
context.successColor      // Green success
context.warningColor      // Orange warning
context.errorColor        // Red error
context.infoColor         // Blue info
context.gray50...gray900  // Gray scale (10 levels)
context.cardColor         // Card background
context.onPrimaryColor    // Text on primary
```

### Typography
```dart
context.yoDisplayLarge / yoDisplayMedium / yoDisplaySmall
context.yoHeadlineLarge / yoHeadlineMedium / yoHeadlineSmall
context.yoTitleLarge / yoTitleMedium / yoTitleSmall
context.yoBodyLarge / yoBodyMedium / yoBodySmall
context.yoLabelLarge / yoLabelMedium / yoLabelSmall
context.yoCurrencyMedium  // Mono font for numbers
```

### Responsive
```dart
context.isMobile          // true if mobile
context.isTablet          // true if tablet
context.isDesktop         // true if desktop
context.adaptiveMd        // Adaptive spacing (16/20/24)
context.adaptivePagePadding  // Adaptive page padding
context.adaptiveGridColumns  // Grid columns (2/3/4)
```

---

## PACKAGE STRUCTURE

```
lib/src/
├── colors/         # Color system & schemes (36+ presets)
├── themes/         # Theme components & shadows
├── fonts/          # Google Fonts integration (51+)
├── layout/         # Responsive & adaptive spacing
├── extensions/     # Context extensions (shortcuts)
├── helpers/        # Formatters, generators, utilities
└── components/     # UI Widget collection (80+)
```

---

## RELATED SKILL FILES

| File | Content |
|------|---------|
| `COMPONENTS.md` | 80+ UI widgets (Display, Form, Feedback, Navigation, Picker) |
| `THEMES.md` | Color schemes, typography, adaptive layout, shadows |
| `HELPERS.md` | Formatters (currency, date, string), ID generators, utilities |

---

## COMMON PATTERNS

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
    YoButton(text: 'Submit', onPressed: () => submitForm()),
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
// Skeleton
YoSkeletonCard(hasImage: true, hasTitle: true);

// Loading overlay
YoLoadingOverlay(isLoading: isSubmitting, message: 'Saving...', child: FormContent());

// Toast
YoToast.success(context, 'Data saved!');
YoToast.error(context, 'Failed to save');
```

### Formatters
```dart
YoCurrencyFormatter.formatRupiahWithUnit(1500000);  // "Rp 1.5 Juta"
YoDateFormatter.formatRelativeTime(date);           // "5 menit lalu"
YoIdGenerator.orderId();                            // "ORD_20260126847"
```

---

## REQUIREMENTS

- Flutter SDK >= 3.0.0
- Dart >= 3.0.0

## DEPENDENCIES

google_fonts, fl_chart, connectivity_plus, file_picker, image_picker, device_info_plus, crypto
