# YoUI Themes & Design System - AI Skill Reference

> **Category**: Theming, Colors, Typography, Layout
> **Purpose**: Design system for consistent, responsive, beautiful Flutter apps

---

## THEME INDEX

| System | Features |
|--------|----------|
| **Colors** | 36+ color schemes, semantic colors, gray palette, gradients |
| **Typography** | 51+ Google Fonts, Material Design 3 text styles |
| **Layout** | Responsive breakpoints, adaptive spacing/padding/radius |
| **Shadows** | 30+ shadow presets, elevation system |
| **Extensions** | Context shortcuts for colors, typography, responsive |

---

## QUICK SETUP

```dart
import 'package:yo_ui/yo_ui.dart';

void main() {
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

## COLOR SYSTEM

### Dynamic Colors (via context)
```dart
// Theme colors
context.primaryColor       // Primary brand
context.secondaryColor     // Secondary
context.accentColor        // Accent
context.backgroundColor    // Background
context.textColor          // Text

// Semantic colors (auto light/dark)
context.successColor       // Green
context.warningColor       // Orange
context.errorColor         // Red
context.infoColor          // Blue

// Gray palette (10 levels)
context.gray50   // Lightest
context.gray100
context.gray200
context.gray300
context.gray400
context.gray500  // Medium
context.gray600
context.gray700
context.gray800
context.gray900  // Darkest

// Computed colors
context.cardColor          // Card background
context.cardBorderColor    // Card border
context.onPrimaryColor     // Text on primary
context.onBackgroundColor  // Text on background
context.onCardColor        // Text on card

// Gradients
context.primaryGradient    // Primary to secondary
context.accentGradient     // Accent to secondary
```

### Via YoColors (alternative)
```dart
YoColors.primary(context)
YoColors.success(context)
YoColors.gray500(context)
```

### Static Colors
```dart
YoColors.white
YoColors.black
YoColors.transparent
YoColors.lightSuccess  // 0xFF00A86B
YoColors.darkSuccess   // 0xFF00D68F
```

---

## COLOR SCHEMES (36+)

### Usage
```dart
YoTheme.lightTheme(context, YoColorScheme.techPurple)
YoTheme.darkTheme(context, YoColorScheme.techPurple)
```

### Available Schemes

| Scheme | Use Case |
|--------|----------|
| `defaultScheme` | Finance, Banking |
| `techPurple` | SaaS, Tech Startup |
| `oceanTeal` | Healthcare, Medical |
| `energyRed` | Social Media, Entertainment |
| `educationIndigo` | E-learning, Education |
| `productivityGreen` | Task Manager |
| `creativeMagenta` | Design Tools |
| `wellnessMint` | Meditation, Mental Health |
| `retailClay` | E-commerce, Retail |
| `travelCoral` | Travel, Hospitality |
| `foodAmber` | Restaurant, Food Delivery |
| `romanticRose` | Wedding, Events |
| `natureEvergreen` | Eco, Sustainability |
| `corporateModern` | B2B, Enterprise |
| `startupVibrant` | Startup |
| `luxuryMinimal` | Premium, Luxury |
| `fitnessEnergy` | Fitness, Sports |
| `gamingNeon` | Gaming, Esports |
| `musicVibes` | Music, Streaming |
| `artGallery` | Art, Museum |
| `codingDark` | Dev Tools, IDE |
| `fashionTrendy` | Fashion |
| `kidsLearning` | Kids Apps |
| `realEstatePro` | Real Estate |
| `cryptoModern` | Cryptocurrency |
| `healthcarePro` | Hospital, Clinic |
| `newsMagazine` | News |
| `outdoorCalm` | Outdoor, Adventure |
| `scienceLab` | Research |
| `communityWarm` | Community, Social |
| `amoledBlack` | AMOLED Dark Mode |
| `midnightBlue` | Dark Professional |
| `carbonDark` | Dashboard Dark |
| `neonCyberpunk` | Futuristic |
| `minimalMono` | Focus Apps |
| `posRetail` | Point of Sale |
| `custom` | User-defined |

### Custom Palette
```dart
final lightPalette = YoCorePalette(
  text: Color(0xFF1A1A1A),
  background: Color(0xFFF5F5F5),
  primary: Color(0xFF6B4EFF),
  secondary: Color(0xFF00D9FF),
  accent: Color(0xFFFF6B6B),
);

final darkPalette = YoCorePalette(
  text: Color(0xFFF5F5F5),
  background: Color(0xFF121212),
  primary: Color(0xFF8B6FFF),
  secondary: Color(0xFF00EEFF),
  accent: Color(0xFFFF8585),
);

setCustomPalette(light: lightPalette, dark: darkPalette);

MaterialApp(
  theme: YoTheme.lightTheme(context, YoColorScheme.custom),
  darkTheme: YoTheme.darkTheme(context, YoColorScheme.custom),
)
```

---

## TYPOGRAPHY

### Setup Font
```dart
YoTextTheme.setFont(
  primary: YoFonts.poppins,    // Display, Headline, Title
  secondary: YoFonts.inter,    // Body, Label
  mono: YoFonts.spaceMono,     // Numbers, Code
);

// Or custom font family
YoTextTheme.setFontFamily(
  primary: 'CustomFont',
  secondary: 'AnotherFont',
  mono: 'MonoFont',
);
```

### Text Styles (via context)
```dart
// Display (57, 45, 36 px)
context.yoDisplayLarge
context.yoDisplayMedium
context.yoDisplaySmall

// Headline (32, 28, 24 px)
context.yoHeadlineLarge
context.yoHeadlineMedium
context.yoHeadlineSmall

// Title (22, 16, 14 px)
context.yoTitleLarge
context.yoTitleMedium
context.yoTitleSmall

// Body (16, 14, 12 px)
context.yoBodyLarge
context.yoBodyMedium
context.yoBodySmall

// Label (14, 12, 11 px)
context.yoLabelLarge
context.yoLabelMedium
context.yoLabelSmall

// Mono/Currency (16, 14, 12 px)
context.yoCurrencyLarge
context.yoCurrencyMedium
context.yoCurrencySmall
```

### Via YoTextTheme (alternative)
```dart
YoTextTheme.headlineMedium(context)
YoTextTheme.bodyLarge(context)
```

### Supported Fonts (YoFonts enum)

**Sans-serif**: roboto, openSans, lato, montserrat, poppins, inter, dmSans, nunito, rubik, barlow, workSans, quicksand, ubuntu, firaSans, karla, manrope, publicSans, lexend, sora, spaceGrotesk

**Serif**: merriweather, bitter, playfairDisplay, crimsonText, ebGaramond, fraunces, spectral

**Display**: teko, anton, bebasNeue, righteous

**Handwriting**: pacifico

**Monospace**: spaceMono

---

## ADAPTIVE LAYOUT

### Breakpoints
| Device | Width |
|--------|-------|
| Mobile | 0 - 599px |
| Tablet | 600 - 1023px |
| Desktop | 1024 - 1439px |
| Large Desktop | 1440px+ |

### Device Detection
```dart
context.isMobile    // true if mobile
context.isTablet    // true if tablet
context.isDesktop   // true if desktop
context.deviceType  // YoDeviceType enum
```

### Responsive Values
```dart
int columns = YoAdaptive.value(
  context,
  mobile: 2,
  tablet: 3,
  desktop: 4,
);

Widget layout = YoAdaptive.value(
  context,
  mobile: MobileLayout(),
  tablet: TabletLayout(),
  desktop: DesktopLayout(),
);
```

### Adaptive Spacing
```dart
context.adaptiveXs   // 4/5/6
context.adaptiveSm   // 8/10/12
context.adaptiveMd   // 16/20/24
context.adaptiveLg   // 24/28/32
context.adaptiveXl   // 32/40/48
```

### Adaptive Padding
```dart
context.adaptivePagePadding     // Page padding
context.adaptiveCardPadding     // Card padding
context.adaptiveSectionPadding  // Section padding
context.adaptiveListPadding     // List item padding
```

### Adaptive Border Radius
```dart
context.adaptiveRadiusSm   // 4/6/8
context.adaptiveRadiusMd   // 8/10/12
context.adaptiveRadiusLg   // 12/14/16
```

### Adaptive Font Size
```dart
context.adaptiveFontDisplay   // 28/36/44
context.adaptiveFontHeadline  // 22/26/32
context.adaptiveFontTitle     // 18/20/24
context.adaptiveFontBody      // 14/15/16
```

### Adaptive Icon Size
```dart
context.adaptiveIconSm   // 18/20/22
context.adaptiveIconMd   // 22/24/26
context.adaptiveIconLg   // 28/32/36
```

### Adaptive Layout Helpers
```dart
context.adaptiveMaxWidth      // inf/720/1200
context.adaptiveGridColumns   // 2/3/4
context.adaptiveGridSpacing   // 12/16/20
```

### Static Spacing (YoSpacing)
```dart
YoSpacing.xs   // 4
YoSpacing.sm   // 8
YoSpacing.md   // 16
YoSpacing.lg   // 24
YoSpacing.xl   // 32
YoSpacing.xxl  // 48
```

### Static Padding (YoPadding)
```dart
YoPadding.all8
YoPadding.all16
YoPadding.horizontal16
YoPadding.vertical12
YoPadding.top8
YoPadding.bottom16
```

---

## SHADOW SYSTEM

### Basic Usage
```dart
Container(
  decoration: BoxDecoration(
    boxShadow: YoBoxShadow.soft(context),
  ),
)
```

### Shadow Presets

| Method | Use Case |
|--------|----------|
| `none()` | No shadow |
| `sm(context)` | Subtle elevation |
| `md(context)` | Cards |
| `lg(context)` | Modals |
| `xl(context)` | Floating elements |
| `soft(context)` | Card, sheet, tile |
| `elevated(context)` | General use |
| `float(context)` | FAB, modal |
| `sharp(context)` | Border, divider |
| `pressed(context)` | Active buttons |
| `hover(context)` | Hover effect |

### Semantic Shadows
```dart
YoBoxShadow.success(context)  // Green tint
YoBoxShadow.warning(context)  // Orange tint
YoBoxShadow.error(context)    // Red tint
YoBoxShadow.info(context)     // Blue tint
```

### Special Effects
```dart
YoBoxShadow.glow(context, color: Colors.blue, blur: 24)
YoBoxShadow.neumorphic(context, blur: 10, distance: 6)
YoBoxShadow.inner(context, blur: 8, spread: -4)
YoBoxShadow.layered(context)
YoBoxShadow.tinted(context)
YoBoxShadow.button(context)
```

### Material Elevation
```dart
YoBoxShadow.elevation0()   // No shadow
YoBoxShadow.elevation1(context)  // Raised button/card
YoBoxShadow.elevation2(context)  // Button pressed
YoBoxShadow.elevation4(context)  // App bar, FAB
YoBoxShadow.elevation8(context)  // Card modal, drawer
YoBoxShadow.elevation16(context) // Navigation drawer
YoBoxShadow.elevation24(context) // Modal bottom sheet
```

---

## CONTEXT EXTENSIONS SUMMARY

### Colors (YoColorContext)
```dart
context.primaryColor
context.secondaryColor
context.accentColor
context.textColor
context.backgroundColor
context.successColor / warningColor / errorColor / infoColor
context.gray50...gray900
context.cardColor
context.onPrimaryColor
context.primaryGradient
```

### Typography (YoContextExtensions)
```dart
context.yoDisplayLarge / yoDisplayMedium / yoDisplaySmall
context.yoHeadlineLarge / yoHeadlineMedium / yoHeadlineSmall
context.yoTitleLarge / yoTitleMedium / yoTitleSmall
context.yoBodyLarge / yoBodyMedium / yoBodySmall
context.yoLabelLarge / yoLabelMedium / yoLabelSmall
context.yoCurrencyLarge / yoCurrencyMedium / yoCurrencySmall
```

### Device (YoDeviceExtensions)
```dart
context.width / context.height
context.isPhone / isTablet / isLandscape / isPortrait
context.screenSize / screenHeight
context.yoPixelRatio / yoTextScaleFactor
context.yoSafeArea / yoViewPadding / yoViewInsets
context.yoHasNotch / yoNotchHeight
context.yoKeyboardVisible / yoKeyboardHeight
```

### Adaptive (YoAdaptiveContext)
```dart
context.deviceType
context.isMobile / isTablet / isDesktop
context.adaptiveXs / adaptiveSm / adaptiveMd / adaptiveLg / adaptiveXl
context.adaptivePagePadding / adaptiveCardPadding
context.adaptiveRadiusSm / adaptiveRadiusMd / adaptiveRadiusLg
context.adaptiveFontDisplay / adaptiveFontHeadline / adaptiveFontTitle
context.adaptiveIconSm / adaptiveIconMd / adaptiveIconLg
context.adaptiveMaxWidth / adaptiveGridColumns / adaptiveGridSpacing
```

### Responsive Value Helper
```dart
double value = context.responsiveValue(
  phone: 12.0,
  tablet: 16.0,
  desktop: 20.0,
);
```

---

## THEME HELPERS

### YoTheme
```dart
ThemeData light = YoTheme.lightTheme(context, YoColorScheme.techPurple);
ThemeData dark = YoTheme.darkTheme(context, YoColorScheme.techPurple);
```

### YoThemeCopyWith
```dart
ThemeData newTheme = YoThemeCopyWith.copyWithColors(
  baseTheme: existingTheme,
  primary: Colors.blue,
  secondary: Colors.teal,
);

ThemeData newTheme = YoThemeCopyWith.copyWithFonts(
  baseTheme: existingTheme,
  primaryFont: 'CustomFont',
);
```

---

## COMMON PATTERNS

```dart
// Responsive card with shadow
Container(
  padding: context.adaptiveCardPadding,
  decoration: BoxDecoration(
    color: context.cardColor,
    borderRadius: BorderRadius.circular(context.adaptiveRadiusMd),
    boxShadow: YoBoxShadow.soft(context),
  ),
  child: Column(
    children: [
      Text('Title', style: context.yoTitleLarge),
      SizedBox(height: context.adaptiveSm),
      Text('Body', style: context.yoBodyMedium),
    ],
  ),
)

// Gradient container
Container(
  decoration: BoxDecoration(
    gradient: context.primaryGradient,
  ),
)

// Responsive layout
if (context.isMobile) {
  return MobileLayout();
} else if (context.isTablet) {
  return TabletLayout();
} else {
  return DesktopLayout();
}
```
