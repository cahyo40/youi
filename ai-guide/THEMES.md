# YoUI Themes & Design System

Dokumentasi sistem desain YoUI, termasuk warna, tipografi, layout responsif, shadows, dan theming.

---

## Table of Contents

- [Quick Start](#quick-start)
- [Color System](#-color-system)
- [Color Schemes](#-color-schemes)
- [Typography](#-typography)
- [Supported Fonts](#-supported-fonts)
- [Adaptive Layout](#-adaptive-layout)
- [Shadow System](#-shadow-system)
- [Context Extensions](#-context-extensions)
- [Theme Helpers](#-theme-helpers)

---

## Quick Start

### Setup Theme di main.dart

```dart
import 'package:yo_ui/yo_ui.dart';

void main() {
  // Opsional: Set font kustom (mendukung 51+ Google Fonts)
  YoTextTheme.setFont(
    primary: YoFonts.poppins,    // Untuk Headline & Title
    secondary: YoFonts.inter,    // Untuk Body & Label
    mono: YoFonts.spaceMono,     // Untuk Angka/Kode
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Pilih salah satu dari 36+ skema warna profesional
      theme: YoTheme.lightTheme(context, YoColorScheme.techPurple),
      darkTheme: YoTheme.darkTheme(context, YoColorScheme.techPurple),
      themeMode: ThemeMode.system,
      home: HomePage(),
    );
  }
}
```

---

## Color System

YoUI menggunakan sistem warna adaptif yang secara otomatis menyesuaikan dengan **Brightness** (Light/Dark) dan **Color Scheme** yang dipilih.

### YoColors - Dynamic Colors

Warna dinamis yang mengikuti skema dan mode tema aktif.

```dart
// Warna utama dari skema aktif
Color primary = YoColors.primary(context);
Color secondary = YoColors.secondary(context);
Color accent = YoColors.accent(context);
Color background = YoColors.background(context);
Color text = YoColors.text(context);

// Atau gunakan context extension (lebih singkat)
Color primary = context.primaryColor;
Color secondary = context.secondaryColor;
Color accent = context.accentColor;
Color background = context.backgroundColor;
Color text = context.textColor;
```

### Semantic Colors

Warna semantik yang menyesuaikan brightness (light/dark mode).

```dart
// Via YoColors
YoColors.success(context);  // Hijau sukses
YoColors.warning(context);  // Oranye warning
YoColors.error(context);    // Merah error
YoColors.info(context);     // Biru info

// Via context extension
context.successColor;
context.warningColor;
context.errorColor;
context.infoColor;
```

### Gray Palette

Skala abu-abu 10 tingkat yang menyesuaikan mode tema.

```dart
// Via YoColors (50-900)
YoColors.gray50(context);   // Paling terang
YoColors.gray100(context);
YoColors.gray200(context);
YoColors.gray300(context);
YoColors.gray400(context);
YoColors.gray500(context);  // Medium
YoColors.gray600(context);
YoColors.gray700(context);
YoColors.gray800(context);
YoColors.gray900(context);  // Paling gelap

// Via context extension
context.gray50;
context.gray500;
context.gray900;
```

### Static Colors

Warna statis yang tidak berubah berdasarkan tema.

```dart
// Konstanta warna
YoColors.white;        // Pure white
YoColors.black;        // Pure black
YoColors.transparent;  // Transparan

// Light mode semantic colors (static)
YoColors.lightSuccess;  // 0xFF00A86B
YoColors.lightWarning;  // 0xFFFFA500
YoColors.lightError;    // 0xFFDC3545
YoColors.lightInfo;     // 0xFF17A2B8

// Dark mode semantic colors (static)
YoColors.darkSuccess;   // 0xFF00D68F
YoColors.darkWarning;   // 0xFFFFB84D
YoColors.darkError;     // 0xFFFF4757
YoColors.darkInfo;      // 0xFF4DCAFF

// Light mode grays (static)
YoColors.lightGray50 ... YoColors.lightGray900;

// Dark mode grays (static)
YoColors.darkGray50 ... YoColors.darkGray900;
```

### Gradients

```dart
// Primary to secondary gradient
Gradient gradient = YoColors.primaryGradient(context);

// Accent to secondary gradient
Gradient accentGradient = YoColors.accentGradient(context);

// Via context extension
context.primaryGradient;
context.accentGradient;
```

### Computed Colors

Warna yang dihitung otomatis dari palette aktif.

```dart
// Via context extension
context.cardColor;         // Warna kartu dengan tint primary
context.cardBorderColor;   // Border kartu
context.onPrimaryColor;    // Teks di atas primary
context.onBackgroundColor; // Teks di atas background
context.onCardColor;       // Teks di atas kartu
context.colorTextBtn;      // Warna teks tombol
```

---

## Color Schemes

YoUI menyediakan **36+ skema warna profesional** yang sudah dikategorikan berdasarkan industri/use case.

### Cara Menggunakan

```dart
// Di MaterialApp
MaterialApp(
  theme: YoTheme.lightTheme(context, YoColorScheme.techPurple),
  darkTheme: YoTheme.darkTheme(context, YoColorScheme.techPurple),
)
```

### Daftar Color Schemes

| Scheme | Kategori | Deskripsi | Cocok Untuk |
|--------|----------|-----------|-------------|
| `defaultScheme` | Finance | Classic Blue - Trust & Stability | Perbankan, Fintech |
| `techPurple` | Technology | Modern Purple - Innovation | SaaS, Tech Startup |
| `oceanTeal` | Healthcare | Clean Teal - Trust | Kesehatan, Medical |
| `energyRed` | Entertainment | Vibrant Red - Energetic | Media Sosial, Entertainment |
| `educationIndigo` | Education | Trustworthy Indigo | E-learning, Edukasi |
| `productivityGreen` | Productivity | Fresh Green - Positive | Task Manager, Produktivitas |
| `creativeMagenta` | Creative | Artistic Magenta | Design Tools, Creative Apps |
| `wellnessMint` | Wellness | Calm Mint | Meditasi, Kesehatan Mental |
| `retailClay` | E-commerce | Warm Clay | Marketplace, Retail |
| `travelCoral` | Travel | Adventure Coral | Travel, Hospitality |
| `foodAmber` | Food & Beverage | Appetizing Amber | Restaurant, Food Delivery |
| `romanticRose` | Events | Romantic Rose | Wedding, Events |
| `natureEvergreen` | Environment | Natural Green | Eco, Sustainability |
| `corporateModern` | Enterprise | Professional | B2B, Enterprise |
| `startupVibrant` | Startup | Energetic | Startup, Innovation |
| `luxuryMinimal` | Luxury | Elegant Black/White | Premium, Luxury Brands |
| `fitnessEnergy` | Fitness | Motivational Red | Fitness, Sports |
| `gamingNeon` | Gaming | Neon Vibes | Gaming, Esports |
| `musicVibes` | Music | Creative Purple | Music, Streaming |
| `artGallery` | Art | Cultural Amber | Art, Museum |
| `codingDark` | Developer | Focus Blue | Dev Tools, IDE |
| `fashionTrendy` | Fashion | Trendy Magenta | Fashion, Style |
| `kidsLearning` | Kids | Playful Pink | Kids Apps, Education |
| `realEstatePro` | Real Estate | Trustworthy Blue | Properti, Real Estate |
| `cryptoModern` | Crypto | Modern Amber | Cryptocurrency, Web3 |
| `healthcarePro` | Healthcare | Clean Green | Hospital, Clinic |
| `newsMagazine` | News | Professional B&W | News, Magazine |
| `outdoorCalm` | Outdoor | Calm Green | Outdoor, Adventure |
| `scienceLab` | Science | Precise Purple | Research, Science |
| `communityWarm` | Community | Warm Amber | Community, Social |
| `amoledBlack` | Dark Mode | Pure Black AMOLED | Battery Saving |
| `midnightBlue` | Dark Mode | Dark Professional | Enterprise Dark |
| `carbonDark` | Dark Mode | Sleek Carbon | Dashboard Dark |
| `neonCyberpunk` | Dark Mode | Cyberpunk Neon | Futuristic |
| `minimalMono` | Minimal | Ultra Monochrome | Focus Apps |
| `posRetail` | POS | Business Focused | Point of Sale |
| `custom` | Custom | User-defined | Kustom |

### Custom Color Palette

Buat palet warna kustom Anda sendiri:

```dart
// Definisikan palet
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

// Set sebagai custom palette
setCustomPalette(light: lightPalette, dark: darkPalette);

// Gunakan di theme
MaterialApp(
  theme: YoTheme.lightTheme(context, YoColorScheme.custom),
  darkTheme: YoTheme.darkTheme(context, YoColorScheme.custom),
)
```

### YoCorePalette Properties

| Property | Type | Description |
|----------|------|-------------|
| `text` | `Color` | Warna teks utama |
| `background` | `Color` | Warna background |
| `primary` | `Color` | Warna primary brand |
| `secondary` | `Color` | Warna secondary |
| `accent` | `Color` | Warna aksen |
| `cardColor` | `Color` | Computed: warna kartu |
| `cardBorderColor` | `Color` | Computed: border kartu |
| `onPrimary` | `Color` | Computed: teks di atas primary |
| `onBackground` | `Color` | Computed: teks di atas background |
| `onCard` | `Color` | Computed: teks di atas kartu |

---

## Typography

YoUI mengintegrasikan Google Fonts dengan sistem Material Design 3.

### Setup Font

```dart
void main() {
  // Menggunakan YoFonts enum
  YoTextTheme.setFont(
    primary: YoFonts.poppins,    // Untuk Display, Headline, Title
    secondary: YoFonts.inter,    // Untuk Body, Label
    mono: YoFonts.spaceMono,     // Untuk angka, kode
  );

  runApp(MyApp());
}

// Atau menggunakan nama font string
YoTextTheme.setFontFamily(
  primary: 'CustomFont',
  secondary: 'AnotherFont',
  mono: 'MonoFont',
);
```

### Text Styles via YoTextTheme

```dart
// Display styles (57, 45, 36 px)
TextStyle display = YoTextTheme.displayLarge(context);
TextStyle display = YoTextTheme.displayMedium(context);
TextStyle display = YoTextTheme.displaySmall(context);

// Headline styles (32, 28, 24 px)
TextStyle headline = YoTextTheme.headlineLarge(context);
TextStyle headline = YoTextTheme.headlineMedium(context);
TextStyle headline = YoTextTheme.headlineSmall(context);

// Title styles (22, 16, 14 px)
TextStyle title = YoTextTheme.titleLarge(context);
TextStyle title = YoTextTheme.titleMedium(context);
TextStyle title = YoTextTheme.titleSmall(context);

// Body styles (16, 14, 12 px)
TextStyle body = YoTextTheme.bodyLarge(context);
TextStyle body = YoTextTheme.bodyMedium(context);
TextStyle body = YoTextTheme.bodySmall(context);

// Label styles (14, 12, 11 px)
TextStyle label = YoTextTheme.labelLarge(context);
TextStyle label = YoTextTheme.labelMedium(context);
TextStyle label = YoTextTheme.labelSmall(context);

// Mono styles (16, 14, 12 px)
TextStyle mono = YoTextTheme.monoLarge(context);
TextStyle mono = YoTextTheme.monoMedium(context);
TextStyle mono = YoTextTheme.monoSmall(context);
```

### Text Styles via Context Extension

Cara lebih ringkas menggunakan extension:

```dart
Text('Display Large', style: context.yoDisplayLarge);
Text('Headline Medium', style: context.yoHeadlineMedium);
Text('Title Small', style: context.yoTitleSmall);
Text('Body Large', style: context.yoBodyLarge);
Text('Label Small', style: context.yoLabelSmall);
Text('Currency', style: context.yoCurrencyMedium); // Mono font
```

### Font Size Reference

| Style | Size | Weight | Font |
|-------|------|--------|------|
| displayLarge | 57px | w400 | Primary |
| displayMedium | 45px | w400 | Primary |
| displaySmall | 36px | w400 | Primary |
| headlineLarge | 32px | w400 | Primary |
| headlineMedium | 28px | w400 | Primary |
| headlineSmall | 24px | w400 | Primary |
| titleLarge | 22px | w500 | Primary |
| titleMedium | 16px | w500 | Primary |
| titleSmall | 14px | w500 | Primary |
| bodyLarge | 16px | w400 | Secondary |
| bodyMedium | 14px | w400 | Secondary |
| bodySmall | 12px | w400 | Secondary |
| labelLarge | 14px | w500 | Secondary |
| labelMedium | 12px | w500 | Secondary |
| labelSmall | 11px | w500 | Secondary |
| monoLarge | 16px | w400 | Mono |
| monoMedium | 14px | w400 | Mono |
| monoSmall | 12px | w400 | Mono |

---

## Supported Fonts

YoUI mendukung **51 Google Fonts** yang dapat digunakan dengan enum `YoFonts`.

### Daftar Font

| Enum | Font Name | Category |
|------|-----------|----------|
| `YoFonts.roboto` | Roboto | Sans-serif |
| `YoFonts.openSans` | Open Sans | Sans-serif |
| `YoFonts.lato` | Lato | Sans-serif |
| `YoFonts.montserrat` | Montserrat | Sans-serif |
| `YoFonts.sourceSans3` | Source Sans 3 | Sans-serif |
| `YoFonts.oswald` | Oswald | Sans-serif |
| `YoFonts.raleway` | Raleway | Sans-serif |
| `YoFonts.poppins` | Poppins | Sans-serif |
| `YoFonts.ptSans` | PT Sans | Sans-serif |
| `YoFonts.nunito` | Nunito | Sans-serif |
| `YoFonts.rubik` | Rubik | Sans-serif |
| `YoFonts.barlow` | Barlow | Sans-serif |
| `YoFonts.workSans` | Work Sans | Sans-serif |
| `YoFonts.inter` | Inter | Sans-serif |
| `YoFonts.dmSans` | DM Sans | Sans-serif |
| `YoFonts.quicksand` | Quicksand | Sans-serif |
| `YoFonts.ubuntu` | Ubuntu | Sans-serif |
| `YoFonts.titilliumWeb` | Titillium Web | Sans-serif |
| `YoFonts.cabin` | Cabin | Sans-serif |
| `YoFonts.firaSans` | Fira Sans | Sans-serif |
| `YoFonts.arimo` | Arimo | Sans-serif |
| `YoFonts.mukta` | Mukta | Sans-serif |
| `YoFonts.heebo` | Heebo | Sans-serif |
| `YoFonts.karla` | Karla | Sans-serif |
| `YoFonts.archivo` | Archivo | Sans-serif |
| `YoFonts.asap` | Asap | Sans-serif |
| `YoFonts.manrope` | Manrope | Sans-serif |
| `YoFonts.overpass` | Overpass | Sans-serif |
| `YoFonts.publicSans` | Public Sans | Sans-serif |
| `YoFonts.alata` | Alata | Sans-serif |
| `YoFonts.josefinSans` | Josefin Sans | Sans-serif |
| `YoFonts.lexend` | Lexend | Sans-serif |
| `YoFonts.sora` | Sora | Sans-serif |
| `YoFonts.spaceGrotesk` | Space Grotesk | Sans-serif |
| `YoFonts.varelaRound` | Varela Round | Sans-serif |
| `YoFonts.merriweather` | Merriweather | Serif |
| `YoFonts.bitter` | Bitter | Serif |
| `YoFonts.playfairDisplay` | Playfair Display | Serif |
| `YoFonts.crimsonText` | Crimson Text | Serif |
| `YoFonts.abhayaLibre` | Abhaya Libre | Serif |
| `YoFonts.ebGaramond` | EB Garamond | Serif |
| `YoFonts.zillaSlab` | Zilla Slab | Slab |
| `YoFonts.fraunces` | Fraunces | Serif |
| `YoFonts.gelasio` | Gelasio | Serif |
| `YoFonts.spectral` | Spectral | Serif |
| `YoFonts.teko` | Teko | Display |
| `YoFonts.anton` | Anton | Display |
| `YoFonts.bebasNeue` | Bebas Neue | Display |
| `YoFonts.pacifico` | Pacifico | Handwriting |
| `YoFonts.righteous` | Righteous | Display |
| `YoFonts.spaceMono` | Space Mono | Monospace |

### Mengakses Font Family Name

```dart
// Dari enum ke string
String fontName = yoFontFamily[YoFonts.poppins]; // 'Poppins'
```

---

## Adaptive Layout

Sistem layout responsif YoUI memudahkan pembuatan UI yang bekerja di Mobile, Tablet, dan Desktop.

### Breakpoints

| Device Type | Width Range |
|-------------|-------------|
| Mobile | 0 - 599px |
| Tablet | 600 - 1023px |
| Desktop | 1024 - 1439px |
| Large Desktop | 1440px+ |

```dart
// Konstanta breakpoint
YoBreakpoints.mobile;      // 0
YoBreakpoints.tablet;      // 600
YoBreakpoints.desktop;     // 1024
YoBreakpoints.largeDesktop; // 1440
```

### Device Detection

```dart
// Via YoAdaptive
YoDeviceType type = YoAdaptive.getDeviceType(context);
bool isMobile = YoAdaptive.isMobile(context);
bool isTablet = YoAdaptive.isTablet(context);
bool isDesktop = YoAdaptive.isDesktop(context);

// Via context extension (lebih singkat)
YoDeviceType type = context.deviceType;
bool isMobile = context.isMobile;
bool isTablet = context.isTablet;
bool isDesktop = context.isDesktop;
```

### Responsive Values

```dart
// Pilih nilai berdasarkan device
int columns = YoAdaptive.value(
  context,
  mobile: 2,
  tablet: 3,
  desktop: 4,
);

// Widget berbeda per device
Widget layout = YoAdaptive.value(
  context,
  mobile: MobileLayout(),
  tablet: TabletLayout(),
  desktop: DesktopLayout(),
);
```

### Adaptive Spacing

Spasi yang otomatis menyesuaikan ukuran layar.

```dart
// Via YoAdaptive
double xs = YoAdaptive.spacingXs(context);  // 4/5/6
double sm = YoAdaptive.spacingSm(context);  // 8/10/12
double md = YoAdaptive.spacingMd(context);  // 16/20/24
double lg = YoAdaptive.spacingLg(context);  // 24/28/32
double xl = YoAdaptive.spacingXl(context);  // 32/40/48
double xxl = YoAdaptive.spacing2xl(context); // 48/56/64

// Via context extension
context.adaptiveXs;  // XS spacing
context.adaptiveSm;  // SM spacing
context.adaptiveMd;  // MD spacing
context.adaptiveLg;  // LG spacing
context.adaptiveXl;  // XL spacing
```

### Adaptive Padding

```dart
// Via YoAdaptive
EdgeInsets page = YoAdaptive.pagePadding(context);
EdgeInsets card = YoAdaptive.cardPadding(context);
EdgeInsets section = YoAdaptive.sectionPadding(context);
EdgeInsets listItem = YoAdaptive.listItemPadding(context);
EdgeInsets button = YoAdaptive.buttonPadding(context);
EdgeInsets input = YoAdaptive.inputPadding(context);

// Via context extension
context.adaptivePagePadding;
context.adaptiveCardPadding;
context.adaptiveSectionPadding;
context.adaptiveListPadding;
```

### Adaptive Border Radius

```dart
// Via YoAdaptive (double values)
double sm = YoAdaptive.radiusSm(context);  // 4/6/8
double md = YoAdaptive.radiusMd(context);  // 8/10/12
double lg = YoAdaptive.radiusLg(context);  // 12/14/16
double xl = YoAdaptive.radiusXl(context);  // 16/20/24

// BorderRadius objects
BorderRadius sm = YoAdaptive.borderRadiusSm(context);
BorderRadius md = YoAdaptive.borderRadiusMd(context);
BorderRadius lg = YoAdaptive.borderRadiusLg(context);
BorderRadius xl = YoAdaptive.borderRadiusXl(context);

// Via context extension
context.adaptiveRadiusSm;
context.adaptiveRadiusMd;
context.adaptiveRadiusLg;
```

### Adaptive Font Size

```dart
// Via YoAdaptive
double display = YoAdaptive.fontDisplay(context);   // 28/36/44
double headline = YoAdaptive.fontHeadline(context); // 22/26/32
double title = YoAdaptive.fontTitle(context);       // 18/20/24
double body = YoAdaptive.fontBody(context);         // 14/15/16
double caption = YoAdaptive.fontCaption(context);   // 12/13/14

// Via context extension
context.adaptiveFontDisplay;
context.adaptiveFontHeadline;
context.adaptiveFontTitle;
context.adaptiveFontBody;
```

### Adaptive Icon Size

```dart
// Via YoAdaptive
double sm = YoAdaptive.iconSm(context);  // 18/20/22
double md = YoAdaptive.iconMd(context);  // 22/24/26
double lg = YoAdaptive.iconLg(context);  // 28/32/36

// Via context extension
context.adaptiveIconSm;
context.adaptiveIconMd;
context.adaptiveIconLg;
```

### Adaptive Layout Helpers

```dart
// Max content width
double maxWidth = YoAdaptive.maxContentWidth(context); // inf/720/1200
double maxWidth = context.adaptiveMaxWidth;

// Grid columns
int columns = YoAdaptive.gridColumns(context); // 2/3/4
int columns = context.adaptiveGridColumns;

// Grid spacing
double spacing = YoAdaptive.gridSpacing(context); // 12/16/20
double spacing = context.adaptiveGridSpacing;
```

### Static Spacing (YoSpacing)

Untuk spacing statis tanpa adaptasi:

```dart
// Spacing values
YoSpacing.xs;  // 4
YoSpacing.sm;  // 8
YoSpacing.md;  // 16
YoSpacing.lg;  // 24
YoSpacing.xl;  // 32
YoSpacing.xxl; // 48

// Border radius
YoSpacing.borderRadiusSm; // Radius.circular(4)
YoSpacing.borderRadiusMd; // Radius.circular(8)
YoSpacing.borderRadiusLg; // Radius.circular(12)
YoSpacing.borderRadiusXl; // Radius.circular(16)

// Container widths
YoSpacing.containerSm; // 640
YoSpacing.containerMd; // 768
YoSpacing.containerLg; // 1024
YoSpacing.containerXl; // 1280
```

### Static Padding (YoPadding)

```dart
// All sides
YoPadding.all4;  // EdgeInsets.all(4)
YoPadding.all8;
YoPadding.all12;
YoPadding.all16;
YoPadding.all20;
YoPadding.all24;
YoPadding.all32;

// Horizontal only
YoPadding.horizontal4;
YoPadding.horizontal8;
YoPadding.horizontal12;
YoPadding.horizontal16;
YoPadding.horizontal20;
YoPadding.horizontal24;
YoPadding.horizontal32;

// Vertical only
YoPadding.vertical4;
YoPadding.vertical8;
YoPadding.vertical12;
YoPadding.vertical16;
YoPadding.vertical20;
YoPadding.vertical24;
YoPadding.vertical32;

// Top/Bottom/Left/Right only
YoPadding.top8;
YoPadding.bottom16;
YoPadding.left12;
YoPadding.right24;

// Custom
YoPadding.fromLTRB(8, 16, 8, 16);
YoPadding.only(top: 10, bottom: 20);
```

### Adaptive Padding (YoPadding)

```dart
// Preset adaptive padding
EdgeInsets page = YoPadding.page(context);
EdgeInsets card = YoPadding.card(context);
EdgeInsets section = YoPadding.section(context);
EdgeInsets listItem = YoPadding.listItem(context);
EdgeInsets button = YoPadding.button(context);
EdgeInsets input = YoPadding.input(context);

// Custom adaptive
EdgeInsets custom = YoPadding.adaptiveAll(context, size: YoSpacingSize.lg);
EdgeInsets horz = YoPadding.adaptiveHorizontal(context, size: YoSpacingSize.md);
EdgeInsets vert = YoPadding.adaptiveVertical(context, size: YoSpacingSize.sm);
EdgeInsets sym = YoPadding.adaptiveSymmetric(
  context,
  horizontal: YoSpacingSize.lg,
  vertical: YoSpacingSize.md,
);
```

---

## Shadow System

YoBoxShadow menyediakan preset bayangan yang dirancang untuk mode terang dan gelap.

### Basic Shadows

```dart
Container(
  decoration: BoxDecoration(
    boxShadow: YoBoxShadow.soft(context),
  ),
)
```

### Shadow Presets

| Method | Parameters | Description | Use Case |
|--------|------------|-------------|----------|
| `none()` | - | No shadow | Reset |
| `sm(context)` | - | Small subtle shadow | Subtle elevation |
| `md(context)` | - | Medium shadow | Cards |
| `lg(context)` | - | Large shadow | Modals |
| `xl(context)` | - | Extra large shadow | Floating elements |
| `xxl(context)` | - | 2XL shadow | Maximum depth |
| `soft(context)` | blur: 16, y: 4 | Soft shadow | Card, sheet, tile |
| `elevated(context)` | blur: 12, y: 4 | Standard elevation | General use |
| `float(context)` | blur: 24, y: 8 | Floating shadow | FAB, modal |
| `sharp(context)` | blur: 2, y: 1 | Sharp shadow | Border, divider |
| `pressed(context)` | blur: 4, y: 1 | Pressed state | Active buttons |
| `hover(context)` | blur: 20, y: 6 | Hover state | Hover effect |

### Semantic Shadows

```dart
// Status shadows with colored tint
YoBoxShadow.success(context);  // Green tint
YoBoxShadow.warning(context);  // Orange tint
YoBoxShadow.error(context);    // Red tint
YoBoxShadow.info(context);     // Blue tint
```

### Special Effects

```dart
// Glow effect
YoBoxShadow.glow(context, color: Colors.blue, blur: 24);

// Neumorphic design
YoBoxShadow.neumorphic(context, blur: 10, distance: 6);

// Inner shadow
YoBoxShadow.inner(context, blur: 8, spread: -4);

// Layered shadow (two layers)
YoBoxShadow.layered(context);

// Directional shadow
YoBoxShadow.directional(context, x: 4, y: 4);

// Brand tinted shadow
YoBoxShadow.tinted(context);

// Button shadow with primary tint
YoBoxShadow.button(context);

// Outline shadow
YoBoxShadow.outline(context, color: Colors.blue);
```

### Material Elevation Shadows

```dart
YoBoxShadow.elevation0();   // No shadow
YoBoxShadow.elevation1(context);  // Raised button/card resting
YoBoxShadow.elevation2(context);  // Raised button pressed
YoBoxShadow.elevation3(context);  // Refresh indicator, search bar
YoBoxShadow.elevation4(context);  // App bar, FAB resting
YoBoxShadow.elevation6(context);  // FAB pressed, snackbar
YoBoxShadow.elevation8(context);  // Card modal, drawer
YoBoxShadow.elevation12(context); // Dialog
YoBoxShadow.elevation16(context); // Navigation drawer
YoBoxShadow.elevation24(context); // Modal bottom sheet
```

### Contoh Penggunaan

```dart
// Card with soft shadow
Container(
  decoration: BoxDecoration(
    color: context.cardColor,
    borderRadius: BorderRadius.circular(12),
    boxShadow: YoBoxShadow.soft(context),
  ),
  child: Padding(
    padding: YoPadding.all16,
    child: Text('Content'),
  ),
)

// Floating action button effect
Container(
  decoration: BoxDecoration(
    boxShadow: YoBoxShadow.float(context),
  ),
  child: FloatingActionButton(...),
)

// Success state with glow
Container(
  decoration: BoxDecoration(
    boxShadow: YoBoxShadow.success(context),
  ),
  child: SuccessCard(),
)
```

---

## Context Extensions

YoUI menyediakan banyak extension pada `BuildContext` untuk akses cepat.

### Color Extensions (YoColorContext)

```dart
// Theme colors
context.primaryColor;
context.secondaryColor;
context.accentColor;
context.textColor;
context.backgroundColor;

// Computed colors
context.cardColor;
context.cardBorderColor;
context.onPrimaryColor;
context.onBackgroundColor;
context.onCardColor;
context.colorTextBtn;

// Semantic colors
context.successColor;
context.warningColor;
context.errorColor;
context.infoColor;

// Gray scale (50-900)
context.gray50;
context.gray100;
context.gray200;
context.gray300;
context.gray400;
context.gray500;
context.gray600;
context.gray700;
context.gray800;
context.gray900;

// Gradients
context.primaryGradient;
context.accentGradient;
```

### Typography Extensions (YoContextExtensions)

```dart
// Display styles
context.yoDisplayLarge;
context.yoDisplayMedium;
context.yoDisplaySmall;

// Headline styles
context.yoHeadlineLarge;
context.yoHeadlineMedium;
context.yoHeadlineSmall;

// Title styles
context.yoTitleLarge;
context.yoTitleMedium;
context.yoTitleSmall;

// Body styles
context.yoBodyLarge;
context.yoBodyMedium;
context.yoBodySmall;

// Label styles
context.yoLabelLarge;
context.yoLabelMedium;
context.yoLabelSmall;

// Mono/Currency styles
context.yoCurrencyLarge;
context.yoCurrencyMedium;
context.yoCurrencySmall;
```

### Device Extensions (YoDeviceExtensions)

```dart
// Screen dimensions
context.width;
context.height;
context.yoScreenWidth;
context.yoScreenHeight;

// Device type checks
context.isPhone;
context.isTablet;
context.isLandscape;
context.isPortrait;

// Screen size categories
context.screenSize;      // ScreenSize enum
context.screenHeight;    // ScreenHeight enum
context.isSmallScreen;
context.isMediumScreen;
context.isLargeScreen;

// Device metrics
context.yoPixelRatio;
context.yoTextScaleFactor;
context.yoPlatformBrightness;

// Safe area & insets
context.yoSafeArea;
context.yoViewPadding;
context.yoViewInsets;

// Notch & navigation
context.yoHasNotch;
context.yoNotchHeight;
context.yoBottomNavBarHeight;
context.yoStatusBarHeight;

// Keyboard
context.yoKeyboardVisible;
context.yoKeyboardHeight;
```

### Adaptive Extensions (YoAdaptiveContext)

```dart
// Device type
context.deviceType;
context.isMobile;
context.isTablet;
context.isDesktop;

// Adaptive spacing
context.adaptiveXs;
context.adaptiveSm;
context.adaptiveMd;
context.adaptiveLg;
context.adaptiveXl;

// Adaptive padding
context.adaptivePagePadding;
context.adaptiveCardPadding;
context.adaptiveSectionPadding;
context.adaptiveListPadding;

// Adaptive border radius
context.adaptiveRadiusSm;
context.adaptiveRadiusMd;
context.adaptiveRadiusLg;

// Adaptive font size
context.adaptiveFontDisplay;
context.adaptiveFontHeadline;
context.adaptiveFontTitle;
context.adaptiveFontBody;

// Adaptive icon size
context.adaptiveIconSm;
context.adaptiveIconMd;
context.adaptiveIconLg;

// Adaptive layout
context.adaptiveMaxWidth;
context.adaptiveGridColumns;
context.adaptiveGridSpacing;
```

### Spacing Extensions

```dart
// Static spacing
context.yoSpacingXs;  // 4
context.yoSpacingSm;  // 8
context.yoSpacingMd;  // 16
context.yoSpacingLg;  // 24
context.yoSpacingXl;  // 32
```

### Responsive Value Helper

```dart
// Pilih nilai berdasarkan ukuran layar
double value = context.responsiveValue(
  phone: 12.0,
  tablet: 16.0,
  desktop: 20.0,
);
```

---

## Theme Helpers

### YoTheme

Kelas utama untuk generate theme.

```dart
// Light theme
ThemeData light = YoTheme.lightTheme(context, YoColorScheme.techPurple);

// Dark theme
ThemeData dark = YoTheme.darkTheme(context, YoColorScheme.techPurple);
```

Theme yang dihasilkan mencakup:
- ColorScheme
- AppBarTheme
- CardTheme
- ElevatedButtonTheme
- OutlinedButtonTheme
- InputDecorationTheme
- ChipTheme
- DividerTheme
- BottomNavigationBarTheme
- DropdownMenuTheme
- TextTheme

### YoThemeCopyWith

Helper untuk menyalin dan memodifikasi theme.

```dart
// Copy dengan custom colors
ThemeData newTheme = YoThemeCopyWith.copyWithColors(
  baseTheme: existingTheme,
  primary: Colors.blue,
  secondary: Colors.teal,
  accent: Colors.orange,
  background: Colors.white,
  surface: Colors.grey[50],
);

// Copy dengan custom fonts
ThemeData newTheme = YoThemeCopyWith.copyWithFonts(
  baseTheme: existingTheme,
  primaryFont: 'CustomFont',
  secondaryFont: 'AnotherFont',
  monoFont: 'MonoFont',
);
```

### YoBottomNavTheme

Theme untuk BottomNavigationBar.

```dart
BottomNavigationBarThemeData lightNav = YoBottomNavTheme.light(context);
BottomNavigationBarThemeData darkNav = YoBottomNavTheme.dark(context);
```

### YoDropdownTheme

Theme untuk DropdownMenu.

```dart
DropdownMenuThemeData lightDropdown = YoDropdownTheme.light(context);
DropdownMenuThemeData darkDropdown = YoDropdownTheme.dark(context);
```

---

## Quick Reference

### Setup Theme

```dart
void main() {
  YoTextTheme.setFont(primary: YoFonts.poppins);
  runApp(MyApp());
}

MaterialApp(
  theme: YoTheme.lightTheme(context, YoColorScheme.techPurple),
  darkTheme: YoTheme.darkTheme(context, YoColorScheme.techPurple),
)
```

### Common Patterns

```dart
// Colors
Color primary = context.primaryColor;
Color error = context.errorColor;
Color gray = context.gray500;

// Typography
TextStyle title = context.yoTitleLarge;
TextStyle body = context.yoBodyMedium;

// Responsive
bool mobile = context.isMobile;
double spacing = context.adaptiveMd;
EdgeInsets padding = context.adaptivePagePadding;

// Shadows
BoxDecoration(boxShadow: YoBoxShadow.soft(context));

// Gradients
Container(
  decoration: BoxDecoration(
    gradient: context.primaryGradient,
  ),
)
```

---

*YoUI Flutter Package v1.1.4 - Build Beautiful Apps Faster*
