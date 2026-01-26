# YoUI Helpers & Utilities Guide

Kumpulan utility, formatter, generator, dan extension untuk mempercepat pengembangan logika aplikasi.

---

## Table of Contents

- [Currency Formatter](#-currency-formatter)
- [Date Formatter](#-date-formatter)
- [String Formatter](#-string-formatter)
- [ID Generator](#-id-generator)
- [Text Input Formatters](#-text-input-formatters)
- [Device Helper](#-device-helper)
- [Connectivity](#-connectivity)
- [Logger](#-logger)

---

## Currency Formatter

`YoCurrencyFormatter` - Utility untuk memformat angka menjadi mata uang dengan dukungan locale.

### Basic Currency Formatting

```dart
// Format currency dengan locale
YoCurrencyFormatter.formatCurrency(1500000);
// Output: "Rp 1.500.000"

YoCurrencyFormatter.formatCurrency(1500000, symbol: '\$', locale: 'en_US');
// Output: "$1,500,000"

// Format dengan decimal
YoCurrencyFormatter.formatCurrency(1500000.50, decimalDigits: 2);
// Output: "Rp 1.500.000,50"
```

### Indonesian Rupiah Formatting

```dart
// Format Rupiah dengan unit (Ribu, Juta, Miliar, Triliun)
YoCurrencyFormatter.formatRupiahWithUnit(1560000);
// Output: "Rp 1.56 Juta"

YoCurrencyFormatter.formatRupiahWithUnit(2500000000);
// Output: "Rp 2.5 Miliar"

// Format compact
YoCurrencyFormatter.formatRupiahCompact(2500000);
// Output: "Rp 2.5Jt"

YoCurrencyFormatter.formatRupiahCompact(1200000000);
// Output: "Rp 1.2M"

// Short unit
YoCurrencyFormatter.formatRupiahWithUnit(1500000, useShortUnit: true);
// Output: "Rp 1.5Jt"
```

### Number Formatting

```dart
// Format number dengan thousand separator
YoCurrencyFormatter.formatNumber(1234567.89);
// Output: "1.234.568"

YoCurrencyFormatter.formatNumber(1234567.89, decimalDigits: 2);
// Output: "1.234.567,89"

// Format compact number
YoCurrencyFormatter.formatCompactNumber(1500000);
// Output: "1,5 jt"

// Format percentage
YoCurrencyFormatter.formatPercentage(0.756, decimalDigits: 1);
// Output: "75.6%"
```

### Large Number Formatting

```dart
// Format angka sangat besar dengan nama unit
YoCurrencyFormatter.formatVeryLargeNumber(1234567890123);
// Output: "1.23 Triliun"

YoCurrencyFormatter.formatVeryLargeNumber(1e15, useShortScale: true);
// Output: "1 Quadrillion"

// Format dengan simbol (K, M, B, T)
YoCurrencyFormatter.formatLargeNumberWithSymbol(1500000);
// Output: "1.5M"
```

### Range Formatting

```dart
// Format number range
YoCurrencyFormatter.formatNumberRange(1000, 5000);
// Output: "1K - 5K"

// Format Rupiah range
YoCurrencyFormatter.formatRupiahRange(500000, 1500000);
// Output: "Rp 500Rb - Rp 1.5Jt"
```

### Parsing

```dart
// Parse string ke number
double? value = YoCurrencyFormatter.parseNumber("1.234.567");
// Output: 1234567.0

// Validasi number
bool isValid = YoCurrencyFormatter.isValidNumber("1.234.567");
// Output: true
```

### Method Reference

| Method | Parameters | Return | Description |
|--------|------------|--------|-------------|
| `formatCurrency()` | `amount`, `symbol?`, `decimalDigits?`, `locale?` | `String` | Format sebagai currency |
| `formatNumber()` | `number`, `decimalDigits?`, `locale?` | `String` | Format dengan thousand separator |
| `formatCompactNumber()` | `number`, `locale?` | `String` | Format compact (1K, 1M) |
| `formatPercentage()` | `value`, `decimalDigits?`, `locale?` | `String` | Format sebagai persentase |
| `formatRupiahWithUnit()` | `amount`, `decimalDigits?`, `showSymbol?`, `useShortUnit?` | `String` | Rupiah dengan unit nama |
| `formatRupiahCompact()` | `amount`, `decimalDigits?`, `showSymbol?` | `String` | Rupiah compact |
| `formatVeryLargeNumber()` | `number`, `locale?`, `decimalDigits?`, `useShortScale?` | `String` | Angka sangat besar |
| `formatLargeNumberWithSymbol()` | `number`, `locale?`, `decimalDigits?` | `String` | Dengan simbol K/M/B/T |
| `formatNumberRange()` | `start`, `end`, `locale?`, `decimalDigits?`, `separator?` | `String` | Format range angka |
| `formatRupiahRange()` | `start`, `end`, `decimalDigits?`, `separator?` | `String` | Format range Rupiah |
| `parseNumber()` | `text`, `locale?` | `double?` | Parse string ke number |
| `isValidNumber()` | `text`, `locale?` | `bool` | Validasi string number |

---

## Date Formatter

`YoDateFormatter` - Utility untuk memformat dan memanipulasi tanggal.

### Basic Date Formatting

```dart
DateTime date = DateTime(2026, 1, 26, 14, 30);

// Format tanggal
YoDateFormatter.formatDate(date);
// Output: "26 Jan 2026"

YoDateFormatter.formatDate(date, format: 'dd MMMM yyyy');
// Output: "26 Januari 2026"

// Format dengan waktu
YoDateFormatter.formatDateTime(date);
// Output: "26 Jan 2026 14:30"

// Format waktu saja
YoDateFormatter.formatTime(date);
// Output: "14:30"

YoDateFormatter.formatTime(date, format: 'HH:mm:ss');
// Output: "14:30:00"
```

### Relative Time

```dart
// Format waktu relatif
YoDateFormatter.formatRelativeTime(DateTime.now().subtract(Duration(minutes: 5)));
// Output: "5 menit lalu"

YoDateFormatter.formatRelativeTime(DateTime.now().subtract(Duration(hours: 2)));
// Output: "2 jam lalu"

YoDateFormatter.formatRelativeTime(DateTime.now().subtract(Duration(days: 3)));
// Output: "3 hari lalu"
```

### Date Comparisons

```dart
DateTime date = DateTime(2026, 1, 26);

// Check hari ini
YoDateFormatter.isToday(date);

// Check kemarin
YoDateFormatter.isYesterday(date);

// Check besok
YoDateFormatter.isTomorrow(date);

// Check minggu ini
YoDateFormatter.isThisWeek(date);

// Check bulan ini
YoDateFormatter.isThisMonth(date);

// Check tahun ini
YoDateFormatter.isThisYear(date);

// Check weekend
YoDateFormatter.isWeekend(date);

// Check weekday
YoDateFormatter.isWeekday(date);

// Check setelah/sebelum hari ini
YoDateFormatter.isAfterToday(date);
YoDateFormatter.isBeforeToday(date);
```

### Date Manipulation

```dart
DateTime date = DateTime(2026, 1, 26, 14, 30);

// Start/End of day
YoDateFormatter.startOfDay(date);   // 2026-01-26 00:00:00
YoDateFormatter.endOfDay(date);     // 2026-01-26 23:59:59

// Start/End of week (Monday-Sunday)
YoDateFormatter.startOfWeek(date);  // 2026-01-20 (Monday)
YoDateFormatter.endOfWeek(date);    // 2026-01-26 (Sunday)

// Start/End of month
YoDateFormatter.startOfMonth(date); // 2026-01-01
YoDateFormatter.endOfMonth(date);   // 2026-01-31

// Add/Subtract days
YoDateFormatter.addDays(date, 7);
YoDateFormatter.subtractDays(date, 7);

// Next/Previous weekday
YoDateFormatter.nextWeekday(date);
YoDateFormatter.previousWeekday(date);
```

### Date Range

```dart
DateTime start = DateTime(2026, 1, 20);
DateTime end = DateTime(2026, 1, 26);

// Format date range
YoDateFormatter.formatDateRange(start, end);
// Output: "20 - 26 Jan 2026" (same month)
// Output: "20 Jan - 15 Feb 2026" (different month)

// Get days in range
List<DateTime> days = YoDateFormatter.getDaysInRange(start, end);
// Output: [2026-01-20, 2026-01-21, ..., 2026-01-26]

// Days between
int diff = YoDateFormatter.daysBetween(start, end);
// Output: 6
```

### Age & Birthday

```dart
DateTime birthDate = DateTime(2000, 5, 15);

// Calculate age
int age = YoDateFormatter.calculateAge(birthDate);
// Output: 25

// Format age
YoDateFormatter.formatAge(birthDate);
// Output: "25 tahun"

// Check if today is birthday
YoDateFormatter.isBirthday(birthDate);

// Days until next birthday
int days = YoDateFormatter.daysUntilBirthday(birthDate);
```

### Duration Formatting

```dart
Duration duration = Duration(hours: 2, minutes: 30);

// Format duration
YoDateFormatter.formatDuration(duration);
// Output: "2 jam 30 menit"

// Format duration short
YoDateFormatter.formatDurationShort(duration);
// Output: "2j 30m"
```

### Get Names

```dart
DateTime date = DateTime(2026, 1, 26);

// Get month name
YoDateFormatter.getMonthName(1);  // "Januari"

// Get day name
YoDateFormatter.getDayName(date);      // "Senin"
YoDateFormatter.getShortDayName(date); // "Sen"

// Get relative day
YoDateFormatter.getRelativeDay(date);
// Output: "Hari ini" / "Kemarin" / "Besok" / "26 Jan 2026"

// Get all names
List<String> months = YoDateFormatter.getMonthNames();
List<String> shortMonths = YoDateFormatter.getShortMonthNames();
List<String> days = YoDateFormatter.getDayNames();
List<String> shortDays = YoDateFormatter.getShortDayNames();
```

### Timestamp Conversion

```dart
// From timestamp (milliseconds)
DateTime date = YoDateFormatter.fromTimestamp(1737878400000);

// To timestamp
int timestamp = YoDateFormatter.toTimestamp(date);
```

### Localization

```dart
// Set localization (Indonesian default)
YoDateFormatter.texts = DateTexts.indonesian;

// Or use English
YoDateFormatter.texts = DateTexts.english;

// Custom texts
YoDateFormatter.texts = DateTexts(
  justNow: 'baru saja',
  minutesAgo: (n) => '$n menit lalu',
  hoursAgo: (n) => '$n jam lalu',
  yesterday: 'kemarin',
  daysAgo: (n) => '$n hari lalu',
  weeksAgo: (n) => '$n minggu lalu',
  monthsAgo: (n) => '$n bulan lalu',
  yearsAgo: (n) => '$n tahun lalu',
  today: 'Hari ini',
  tomorrow: 'Besok',
  durationHm: (h, m) => '$h jam $m menit',
  durationM: (m) => '$m menit',
  durationS: (s) => '$s detik',
);
```

---

## String Formatter

`YoStringFormatter` - Utility untuk memformat dan memanipulasi string.

### Case Conversion

```dart
// Title Case
YoStringFormatter.titleCase('hello world');
// Output: "Hello World"

// Capitalize first
YoStringFormatter.capitalizeFirst('hello world');
// Output: "Hello world"

// camelCase to Title Case
YoStringFormatter.camelCaseToTitle('helloWorld');
// Output: "Hello World"

// snake_case to Title Case
YoStringFormatter.snakeCaseToTitle('hello_world');
// Output: "Hello World"

// To camelCase
YoStringFormatter.toCamelCase('Hello World');
// Output: "helloWorld"

// To snake_case
YoStringFormatter.toSnakeCase('Hello World');
// Output: "hello_world"

// To kebab-case
YoStringFormatter.toKebabCase('Hello World');
// Output: "hello-world"
```

### Phone Number Formatting

```dart
// Format Indonesian phone
YoStringFormatter.formatPhoneNumber('081234567890');
// Output: "0812-3456-7890"

// Obscure phone for privacy
YoStringFormatter.obscurePhoneNumber('081234567890');
// Output: "0812****7890"
```

### Number & Percentage

```dart
// Format number
YoStringFormatter.formatNumber(1234567);
// Output: "1.234.567"

// Format percentage
YoStringFormatter.formatPercentage(0.756, decimalPlaces: 1);
// Output: "75.6%"
```

### Address Formatting

```dart
// Format address with abbreviations
YoStringFormatter.formatAddress('Jalan Sudirman No. 123, Kelurahan Menteng');
// Output: "Jl. Sudirman No. 123, Kel. Menteng"

// Format postal code
YoStringFormatter.formatPostalCode('12345');
// Output: "12345"
```

### Email & URL

```dart
// Obscure email for privacy
YoStringFormatter.obscureEmail('johndoe@example.com');
// Output: "joh****@example.com"

// Format URL for display
YoStringFormatter.formatUrlDisplay('https://www.example.com/page?query=1');
// Output: "example.com"
```

### Name Formatting

```dart
// Get initials
YoStringFormatter.getInitials('John Doe');
// Output: "JD"

YoStringFormatter.getInitials('John Michael Doe', maxInitials: 3);
// Output: "JMD"

// Format name short
YoStringFormatter.formatNameShort('John Michael Doe');
// Output: "John M. D."
```

### Duration Formatting

```dart
// Format duration (seconds to MM:SS)
YoStringFormatter.formatDuration(185);
// Output: "03:05"

// Format duration long
YoStringFormatter.formatDurationLong(3725);
// Output: "1 jam 2 menit"
```

### File Operations

```dart
// Format file size
YoStringFormatter.formatFileSize(1048576);
// Output: "1.0 MB"

YoStringFormatter.formatFileSize(1536);
// Output: "1.5 KB"

// Get filename from path
YoStringFormatter.getFileName('/path/to/file.pdf');
// Output: "file.pdf"

// Get file extension
YoStringFormatter.getFileExtension('document.pdf');
// Output: "pdf"
```

### Username Formatting

```dart
// Format username with @
YoStringFormatter.formatUsername('johndoe');
// Output: "@johndoe"
```

### Text Truncation

```dart
// Truncate with ellipsis
YoStringFormatter.truncateWithEllipsis('This is a very long text', maxLength: 15);
// Output: "This is a ve..."

// Truncate middle
YoStringFormatter.truncateMiddle('1234567890123456', visibleStart: 4, visibleEnd: 4);
// Output: "1234...3456"
```

### Text Cleaning

```dart
// Clean alphanumeric only
YoStringFormatter.cleanAlphanumeric('Hello@World#123!');
// Output: "HelloWorld123"

// Remove emojis
YoStringFormatter.removeEmojis('Hello 😀 World 🌍');
// Output: "Hello  World "

// Extract numbers only
YoStringFormatter.extractNumbers('Phone: 0812-3456-7890');
// Output: "081234567890"
```

### Word Count

```dart
int count = YoStringFormatter.wordCount('Hello World');
// Output: 2
```

### Boolean Formatting

```dart
YoStringFormatter.formatBoolean(true);
// Output: "Ya"

YoStringFormatter.formatBoolean(false, trueText: 'Active', falseText: 'Inactive');
// Output: "Inactive"
```

### Text Masking

```dart
YoStringFormatter.maskText('1234567890', visibleStart: 2, visibleEnd: 2);
// Output: "12******90"

YoStringFormatter.maskText('password123', visibleStart: 0, visibleEnd: 3, maskChar: 'x');
// Output: "xxxxxxxx123"
```

---

## ID Generator

`YoIdGenerator` - Utility untuk generate berbagai format ID secara offline.

### Basic ID Generation

```dart
// Numeric ID
YoIdGenerator.numericId();         // "84729163"
YoIdGenerator.numericId(length: 12); // "847291635820"

// Alphanumeric ID
YoIdGenerator.alphanumericId();           // "A8k2Lm9xPq4R"
YoIdGenerator.alphanumericId(length: 16); // "A8k2Lm9xPq4R5nBv"

// UUID v4
YoIdGenerator.uuid();
// Output: "550e8400-e29b-41d4-a716-446655440000"
```

### Prefixed IDs

```dart
// Custom prefix
YoIdGenerator.prefixedId('INV', length: 8);
// Output: "INV_12345678"

YoIdGenerator.prefixedId('PRD', length: 6, numeric: false);
// Output: "PRD_A8k2Lm"

// Preset prefixes
YoIdGenerator.userId();        // "USR_12345678"
YoIdGenerator.orderId();       // "ORD_20260126847"
YoIdGenerator.transactionId(); // "TRX_12345678"
YoIdGenerator.productId();     // "PROD_12345678"
YoIdGenerator.categoryId();    // "CAT_123456"
```

### Timestamp-based IDs

```dart
// Timestamp ID (ddMMyyyyHHmmss)
YoIdGenerator.timestampId();
// Output: "26012026143052"

// Short timestamp ID (yyMMddHHmmss)
YoIdGenerator.shortTimestampId();
// Output: "260126143052"

// Timestamp with random suffix
YoIdGenerator.timestampWithRandomId(randomLength: 4);
// Output: "26012026143052_8472"
```

### Hash-based IDs

```dart
// MD5 hash
YoIdGenerator.md5Id('input string');
// Output: "0cc175b9c0f1b6a831c399e269772661"

// SHA-1 hash
YoIdGenerator.sha1Id('input string');
// Output: "86f7e437faa5a7fce15d1ddcb9eaeaea377667b8"

// SHA-256 hash
YoIdGenerator.sha256Id('input string');
// Output: "ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b..."

// Short hash ID
YoIdGenerator.shortHashId('input string', length: 8);
// Output: "0cc175b9"
```

### Sequential IDs

```dart
// Sequential with counter
YoIdGenerator.sequentialId('INV', 42, padding: 6);
// Output: "INV_000042"

// Auto-increment with date
YoIdGenerator.autoIncrementId('ORD', 1);
// Output: "ORD_20260126_001"
```

### Custom Format IDs

```dart
// Custom format (X = random character)
YoIdGenerator.customFormatId('XX-XXXX-XXXX');
// Output: "A8-K2L9-MX4R"

YoIdGenerator.customFormatId('XXX-XXX', charset: '0123456789');
// Output: "847-291"
```

### License Key Style

```dart
// License key format
YoIdGenerator.licenseKeyId();
// Output: "A8K2-L9MX-4RPQ-5NBV"

YoIdGenerator.licenseKeyId(blocks: 5, blockLength: 5);
// Output: "A8K2L-9MX4R-PQ5NB-VWXYZ-12345"
```

### Coupon Codes

```dart
// Coupon code
YoIdGenerator.couponCode();
// Output: "A8K2L9MX"

YoIdGenerator.couponCode(prefix: 'SALE', length: 6);
// Output: "SALEA8K2L9"
```

### Batch Generation

```dart
// Generate multiple IDs
List<String> ids = YoIdGenerator.batchGenerate(count: 10, length: 8);
// Output: ["A8K2L9MX", "4RPQ5NBV", ...]

// Generate unique IDs (no duplicates)
List<String> uniqueIds = YoIdGenerator.batchGenerateUnique(
  count: 10, 
  prefix: 'USR', 
  length: 6,
);
```

### Validation

```dart
// Validate numeric ID
YoIdGenerator.isValidNumericId('12345678');  // true
YoIdGenerator.isValidNumericId('1234', length: 8);  // false

// Validate alphanumeric ID
YoIdGenerator.isValidAlphanumericId('A8K2L9MX');  // true

// Validate UUID
YoIdGenerator.isValidUuid('550e8400-e29b-41d4-a716-446655440000');  // true

// Validate prefixed ID
YoIdGenerator.isValidPrefixedId('USR_12345678', 'USR');  // true
```

### ID Parsing

```dart
// Extract prefix
YoIdGenerator.extractPrefix('USR_12345678');
// Output: "USR"

// Extract numeric part
YoIdGenerator.extractNumericPart('USR_12345678');
// Output: "12345678"
```

### Checksum IDs

```dart
// Generate ID with checksum
String id = YoIdGenerator.idWithChecksum('USR12345');
// Output: "USR12345_A8"

// Verify checksum
bool valid = YoIdGenerator.verifyChecksum('USR12345_A8');
// Output: true
```

---

## Text Input Formatters

TextInputFormatter untuk digunakan dengan TextField/TextFormField.

### IndonesiaCurrencyFormatter

```dart
YoTextFormField(
  labelText: 'Price',
  inputFormatters: [
    IndonesiaCurrencyFormatter(),
  ],
)
// Input: 1500000
// Display: "Rp 1.500.000"

// Options
IndonesiaCurrencyFormatter(
  showSymbol: true,   // Show "Rp " prefix
  symbol: 'Rp ',      // Custom symbol
)
```

### CurrencyTextInputFormatter

```dart
YoTextFormField(
  inputFormatters: [
    CurrencyTextInputFormatter(
      thousandSeparator: '.',
      decimalSeparator: ',',
      decimalDigits: 2,
      allowDecimal: true,
    ),
  ],
)
// Input: 1500000.50
// Display: "1.500.000,50"
```

### IndonesiaPhoneFormatter

```dart
YoTextFormField(
  labelText: 'Phone Number',
  inputFormatters: [
    IndonesiaPhoneFormatter(),
  ],
)
// Input: 081234567890
// Display: "0812 3456 7890"

// Or international format
// Input: +6281234567890
// Display: "+62 812 3456 7890"
```

### PhoneNumberFormatter

```dart
YoTextFormField(
  inputFormatters: [
    PhoneNumberFormatter(
      separator: '-',
      groupSizes: [4, 4, 4],
    ),
  ],
)
// Input: 123456789012
// Display: "1234-5678-9012"
```

### CreditCardFormatter

```dart
YoTextFormField(
  labelText: 'Card Number',
  inputFormatters: [
    CreditCardFormatter(),
  ],
)
// Input: 1234567890123456
// Display: "1234 5678 9012 3456"

// Custom separator
CreditCardFormatter(separator: '-')
// Display: "1234-5678-9012-3456"
```

### DecimalTextInputFormatter

```dart
YoTextFormField(
  inputFormatters: [
    DecimalTextInputFormatter(
      decimalPlaces: 2,
      decimalSeparator: ',',
    ),
  ],
)
// Input: 123.45
// Display: "123,45"
```

### UpperCaseTextFormatter

```dart
YoTextFormField(
  inputFormatters: [
    UpperCaseTextFormatter(),
  ],
)
// Input: hello
// Display: "HELLO"
```

### LowerCaseTextFormatter

```dart
YoTextFormField(
  inputFormatters: [
    LowerCaseTextFormatter(),
  ],
)
// Input: HELLO
// Display: "hello"
```

### Combined Usage

```dart
YoTextFormField(
  labelText: 'Amount',
  inputType: YoInputType.number,
  inputFormatters: [
    FilteringTextInputFormatter.digitsOnly,
    IndonesiaCurrencyFormatter(),
  ],
  onChanged: (value) {
    // Get raw number value
    String rawValue = value.replaceAll(RegExp(r'[^\d]'), '');
    int amount = int.tryParse(rawValue) ?? 0;
  },
)
```

---

## Device Helper

`YoDeviceHelper` - Utility untuk informasi perangkat dan platform.

### Device Info

```dart
// Get comprehensive device info
Map<String, dynamic> info = await YoDeviceHelper.getDeviceInfo();
// Returns: {
//   'model': 'Pixel 6',
//   'brand': 'Google',
//   'osVersion': '14',
//   'isPhysicalDevice': true,
//   ...
// }
```

### Platform Detection

```dart
// Get platform type
PlatformType platform = YoDeviceHelper.getPlatformType();
// Output: PlatformType.android

// Get platform name
String name = YoDeviceHelper.getPlatformName();
// Output: "Android"

// Platform checks
bool isWeb = YoDeviceHelper.isWeb;
bool isMobile = YoDeviceHelper.isMobile;    // Android or iOS
bool isDesktop = YoDeviceHelper.isDesktop;  // Windows, macOS, Linux
```

### Screen Size

```dart
// Check device type
bool isTablet = YoDeviceHelper.isTablet(context);
bool isPhone = YoDeviceHelper.isPhone(context);

// Get screen size category
ScreenSize size = YoDeviceHelper.getScreenSize(context);
// Output: ScreenSize.small / medium / large

// Get screen height category
ScreenHeight height = YoDeviceHelper.getScreenHeight(context);
// Output: ScreenHeight.small / medium / large
```

### Orientation

```dart
bool isLandscape = YoDeviceHelper.isLandscape(context);
bool isPortrait = YoDeviceHelper.isPortrait(context);
```

### Device Metrics

```dart
// Pixel ratio
double ratio = YoDeviceHelper.getPixelRatio(context);

// Text scale factor
double scale = YoDeviceHelper.getTextScaleFactor(context);

// Platform brightness
Brightness brightness = YoDeviceHelper.getPlatformBrightness(context);
```

### Safe Area & Insets

```dart
// Safe area padding
EdgeInsets safeArea = YoDeviceHelper.getSafeAreaPadding(context);

// View padding
EdgeInsets viewPadding = YoDeviceHelper.getViewPadding(context);

// View insets
EdgeInsets viewInsets = YoDeviceHelper.getViewInsets(context);
```

### Notch & Navigation Bar

```dart
// Check notch
bool hasNotch = YoDeviceHelper.hasNotch(context);

// Get notch height
double notchHeight = YoDeviceHelper.getNotchHeight(context);

// Get bottom nav bar height
double navHeight = YoDeviceHelper.getBottomNavigationBarHeight(context);

// Get status bar height
double statusHeight = YoDeviceHelper.getStatusBarHeight(context);
```

### Keyboard

```dart
// Check keyboard visibility
bool isVisible = YoDeviceHelper.isKeyboardVisible(context);

// Get keyboard height
double keyboardHeight = YoDeviceHelper.getKeyboardHeight(context);
```

### Enums

```dart
enum ScreenSize { small, medium, large }
enum ScreenHeight { small, medium, large }
enum PlatformType { android, ios, windows, macos, linux, web, unknown }
```

---

## Connectivity

`YoConnectivity` - Utility untuk monitoring koneksi internet.

### Setup

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize connectivity monitoring
  await YoConnectivity.initialize();
  
  runApp(MyApp());
}
```

### Check Connection

```dart
// Check current connection status
bool isConnected = YoConnectivity.isConnected;

// Force check connection
bool connected = await YoConnectivity.checkConnection();

// Get connection type name
String type = YoConnectivity.connectionName;
// Output: "WiFi", "Mobile", "None", etc.
```

### Listen to Changes

```dart
// Add listener
void onConnectionChanged(bool isConnected) {
  if (isConnected) {
    print('Connected to internet');
  } else {
    print('No internet connection');
  }
}

YoConnectivity.addListener(onConnectionChanged);

// Remove listener
YoConnectivity.removeListener(onConnectionChanged);
```

### Ensure Connection

```dart
// Execute function only if connected
try {
  final result = await YoConnectivity.ensureConnection(
    () async {
      return await api.fetchData();
    },
    errorMessage: 'Tidak ada koneksi internet',
    timeout: Duration(seconds: 30),
  );
} on YoConnectionException catch (e) {
  print(e.message); // "Tidak ada koneksi internet"
}
```

### Cleanup

```dart
// Dispose when done (e.g., in app termination)
YoConnectivity.dispose();
```

### YoConnectionException

```dart
try {
  await someNetworkOperation();
} on YoConnectionException catch (e) {
  showDialog(
    title: 'Error',
    message: e.message,
  );
}
```

---

## Logger

`YoLogger` - Logger berwarna untuk debugging.

### Basic Usage

```dart
// Debug level (cyan)
YoLogger.debug('Fetching data from API', tag: 'API');

// Info level (green)
YoLogger.info('User logged in successfully');

// Warning level (yellow)
YoLogger.warning('Memory usage is high', tag: 'PERFORMANCE');

// Error level (red)
YoLogger.error('Failed to fetch data', error: exception, stackTrace: stackTrace);

// Critical level (magenta)
YoLogger.critical('Application crashed!', error: exception);
```

### Configuration

```dart
// Enable logging (default: enabled)
YoLogger.enable();

// Disable logging (e.g., for production)
YoLogger.disable();

// Set minimum log level
YoLogger.setLevel(YoLogLevel.warning);
// Only warning, error, and critical will be shown
```

### Log Levels

```dart
enum YoLogLevel {
  debug,    // 0 - Detailed debugging
  info,     // 1 - General information
  warning,  // 2 - Warnings
  error,    // 3 - Errors
  critical, // 4 - Critical errors
}
```

### Output Format

```
[DEBUG] 14:30:52 [API] Fetching data from API
[INFO] 14:30:53 User logged in successfully
[WARNING] 14:30:54 [PERFORMANCE] Memory usage is high
[ERROR] 14:30:55 Failed to fetch data
  Error: SocketException: Connection refused
  StackTrace: ...
[CRITICAL] 14:30:56 Application crashed!
```

### Best Practices

```dart
// Development mode
void main() {
  if (kDebugMode) {
    YoLogger.enable();
    YoLogger.setLevel(YoLogLevel.debug);
  } else {
    YoLogger.disable();
  }
  
  runApp(MyApp());
}

// Usage in code
class ApiService {
  Future<void> fetchData() async {
    YoLogger.debug('Starting fetch...', tag: 'API');
    
    try {
      final response = await http.get(url);
      YoLogger.info('Fetch successful: ${response.statusCode}', tag: 'API');
    } catch (e, stack) {
      YoLogger.error('Fetch failed', error: e, stackTrace: stack, tag: 'API');
      rethrow;
    }
  }
}
```

---

## Quick Reference

### Import

```dart
import 'package:yo_ui/yo_ui.dart';
```

### Common Patterns

```dart
// Currency formatting
String price = YoCurrencyFormatter.formatRupiahWithUnit(1500000);
// "Rp 1.5 Juta"

// Date formatting
String date = YoDateFormatter.formatRelativeTime(createdAt);
// "5 menit lalu"

// String formatting
String initials = YoStringFormatter.getInitials('John Doe');
// "JD"

// ID generation
String orderId = YoIdGenerator.orderId();
// "ORD_20260126847"

// Input formatting
YoTextFormField(
  inputFormatters: [IndonesiaCurrencyFormatter()],
)

// Connectivity check
if (YoConnectivity.isConnected) {
  await fetchData();
}

// Logging
YoLogger.info('Operation completed');
```

---

*YoUI Flutter Package v1.1.4 - Build Beautiful Apps Faster*
