# YoUI Helpers & Utilities - AI Skill Reference

> **Category**: Utilities, Formatters, Generators
> **Purpose**: Helper classes for app logic - formatting, ID generation, device info, connectivity

---

## UTILITY INDEX

| Utility | Purpose |
|---------|---------|
| `YoCurrencyFormatter` | Currency & number formatting |
| `YoDateFormatter` | Date formatting & manipulation |
| `YoStringFormatter` | String manipulation |
| `YoIdGenerator` | ID generation (offline) |
| `TextInputFormatters` | Input field formatters |
| `YoDeviceHelper` | Device & platform info |
| `YoConnectivity` | Internet connection monitoring |
| `YoLogger` | Debug logging |

---

## YoCurrencyFormatter

### Currency Formatting

| Method | Parameters | Returns | Description |
|--------|------------|---------|-------------|
| `formatCurrency` | `amount`, `symbol?`, `decimalDigits?` | String | Format with currency symbol |
| `formatRupiahWithUnit` | `amount` | String | Format Rupiah with Ribu/Juta/Miliar |
| `formatRupiahCompact` | `amount` | String | Short format (Rb/Jt/M) |

```dart
YoCurrencyFormatter.formatCurrency(1500000);                    // "Rp 1.500.000"
YoCurrencyFormatter.formatCurrency(1500000, symbol: '\$');      // "$1,500,000"
YoCurrencyFormatter.formatCurrency(1500000.50, decimalDigits: 2); // "Rp 1.500.000,50"
```

### Rupiah with Unit

```dart
YoCurrencyFormatter.formatRupiahWithUnit(1560000);    // "Rp 1.56 Juta"
YoCurrencyFormatter.formatRupiahWithUnit(2500000000); // "Rp 2.5 Miliar"
YoCurrencyFormatter.formatRupiahCompact(2500000);     // "Rp 2.5Jt"
```

### Number Formatting

| Method | Parameters | Returns | Description |
|--------|------------|---------|-------------|
| `formatNumber` | `number`, `decimalDigits?` | String | Basic number format |
| `formatCompactNumber` | `number` | String | Compact with unit (rb/jt) |
| `formatPercentage` | `value`, `decimalDigits?` | String | Percentage format |

```dart
YoCurrencyFormatter.formatNumber(1234567.89);                // "1.234.568"
YoCurrencyFormatter.formatNumber(1234567.89, decimalDigits: 2); // "1.234.567,89"
YoCurrencyFormatter.formatCompactNumber(1500000);            // "1,5 jt"
YoCurrencyFormatter.formatPercentage(0.756, decimalDigits: 1); // "75.6%"
```

### Large Numbers

```dart
YoCurrencyFormatter.formatVeryLargeNumber(1234567890123);   // "1.23 Triliun"
YoCurrencyFormatter.formatLargeNumberWithSymbol(1500000);   // "1.5M"
```

### Range Formatting

```dart
YoCurrencyFormatter.formatNumberRange(1000, 5000);          // "1K - 5K"
YoCurrencyFormatter.formatRupiahRange(500000, 1500000);     // "Rp 500Rb - Rp 1.5Jt"
```

### Parsing

```dart
double? value = YoCurrencyFormatter.parseNumber("1.234.567"); // 1234567.0
bool valid = YoCurrencyFormatter.isValidNumber("1.234.567");  // true
```

---

## YoDateFormatter

### Basic Formatting

| Method | Parameters | Returns | Description |
|--------|------------|---------|-------------|
| `formatDate` | `date`, `format?` | String | Format date |
| `formatDateTime` | `date`, `format?` | String | Format date and time |
| `formatTime` | `date`, `format?` | String | Format time only |

```dart
YoDateFormatter.formatDate(date);                       // "26 Jan 2026"
YoDateFormatter.formatDate(date, format: 'dd MMMM yyyy'); // "26 Januari 2026"
YoDateFormatter.formatDateTime(date);                   // "26 Jan 2026 14:30"
YoDateFormatter.formatTime(date);                       // "14:30"
```

### Relative Time

```dart
YoDateFormatter.formatRelativeTime(DateTime.now().subtract(Duration(minutes: 5))); // "5 menit lalu"
YoDateFormatter.formatRelativeTime(DateTime.now().subtract(Duration(hours: 2)));   // "2 jam lalu"
YoDateFormatter.formatRelativeTime(DateTime.now().subtract(Duration(days: 3)));    // "3 hari lalu"
```

### Date Comparisons

| Method | Returns | Description |
|--------|---------|-------------|
| `isToday(date)` | bool | Is date today |
| `isYesterday(date)` | bool | Is date yesterday |
| `isTomorrow(date)` | bool | Is date tomorrow |
| `isThisWeek(date)` | bool | Is date this week |
| `isThisMonth(date)` | bool | Is date this month |
| `isWeekend(date)` | bool | Is date weekend |
| `isAfterToday(date)` | bool | Is date after today |

```dart
YoDateFormatter.isToday(date);
YoDateFormatter.isYesterday(date);
YoDateFormatter.isTomorrow(date);
YoDateFormatter.isThisWeek(date);
YoDateFormatter.isThisMonth(date);
YoDateFormatter.isWeekend(date);
YoDateFormatter.isAfterToday(date);
```

### Date Manipulation

| Method | Returns | Description |
|--------|---------|-------------|
| `startOfDay(date)` | DateTime | Date at 00:00:00 |
| `endOfDay(date)` | DateTime | Date at 23:59:59 |
| `startOfWeek(date)` | DateTime | Monday of the week |
| `endOfMonth(date)` | DateTime | Last day of month |
| `addDays(date, days)` | DateTime | Add days to date |
| `subtractDays(date, days)` | DateTime | Subtract days |

```dart
YoDateFormatter.startOfDay(date);    // 00:00:00
YoDateFormatter.endOfDay(date);      // 23:59:59
YoDateFormatter.startOfWeek(date);   // Monday
YoDateFormatter.endOfMonth(date);    // Last day
YoDateFormatter.addDays(date, 7);
YoDateFormatter.subtractDays(date, 7);
```

### Date Range

```dart
YoDateFormatter.formatDateRange(start, end);  // "20 - 26 Jan 2026"
YoDateFormatter.getDaysInRange(start, end);   // List<DateTime>
YoDateFormatter.daysBetween(start, end);      // int
```

### Age & Birthday

```dart
int age = YoDateFormatter.calculateAge(birthDate);  // 25
YoDateFormatter.formatAge(birthDate);               // "25 tahun"
YoDateFormatter.isBirthday(birthDate);              // bool
YoDateFormatter.daysUntilBirthday(birthDate);       // int
```

### Duration

```dart
YoDateFormatter.formatDuration(Duration(hours: 2, minutes: 30)); // "2 jam 30 menit"
YoDateFormatter.formatDurationShort(duration);                    // "2j 30m"
```

### Get Names

```dart
YoDateFormatter.getMonthName(1);      // "Januari"
YoDateFormatter.getDayName(date);     // "Senin"
YoDateFormatter.getShortDayName(date); // "Sen"
YoDateFormatter.getRelativeDay(date); // "Hari ini" / "Kemarin" / "Besok"
```

### Localization

```dart
YoDateFormatter.texts = DateTexts.indonesian;  // Default
YoDateFormatter.texts = DateTexts.english;
```

---

## YoStringFormatter

### Case Conversion

| Method | Input | Output |
|--------|-------|--------|
| `titleCase` | 'hello world' | 'Hello World' |
| `capitalizeFirst` | 'hello world' | 'Hello world' |
| `toCamelCase` | 'Hello World' | 'helloWorld' |
| `toSnakeCase` | 'Hello World' | 'hello_world' |
| `toKebabCase` | 'Hello World' | 'hello-world' |

```dart
YoStringFormatter.titleCase('hello world');          // "Hello World"
YoStringFormatter.capitalizeFirst('hello world');    // "Hello world"
YoStringFormatter.toCamelCase('Hello World');        // "helloWorld"
YoStringFormatter.toSnakeCase('Hello World');        // "hello_world"
YoStringFormatter.toKebabCase('Hello World');        // "hello-world"
```

### Phone Number

```dart
YoStringFormatter.formatPhoneNumber('081234567890');  // "0812-3456-7890"
YoStringFormatter.obscurePhoneNumber('081234567890'); // "0812****7890"
```

### Names

```dart
YoStringFormatter.getInitials('John Doe');                  // "JD"
YoStringFormatter.getInitials('John Michael Doe', maxInitials: 3); // "JMD"
YoStringFormatter.formatNameShort('John Michael Doe');      // "John M. D."
```

### Email & URL

```dart
YoStringFormatter.obscureEmail('johndoe@example.com');  // "joh****@example.com"
YoStringFormatter.formatUrlDisplay('https://www.example.com/page'); // "example.com"
```

### File Operations

```dart
YoStringFormatter.formatFileSize(1048576);    // "1.0 MB"
YoStringFormatter.getFileName('/path/file.pdf'); // "file.pdf"
YoStringFormatter.getFileExtension('doc.pdf'); // "pdf"
```

### Text Manipulation

| Method | Description |
|--------|-------------|
| `truncateWithEllipsis` | Truncate text with "..." |
| `truncateMiddle` | Truncate middle of text |
| `cleanAlphanumeric` | Remove non-alphanumeric |
| `removeEmojis` | Remove emoji characters |
| `extractNumbers` | Extract only numbers |
| `maskText` | Mask text with asterisks |

```dart
YoStringFormatter.truncateWithEllipsis('Long text', maxLength: 10);  // "Long te..."
YoStringFormatter.truncateMiddle('1234567890', visibleStart: 4, visibleEnd: 4); // "1234...7890"
YoStringFormatter.cleanAlphanumeric('Hello@World#123!'); // "HelloWorld123"
YoStringFormatter.removeEmojis('Hello 😀');              // "Hello "
YoStringFormatter.extractNumbers('Phone: 0812-3456');    // "08123456"
YoStringFormatter.maskText('1234567890', visibleStart: 2, visibleEnd: 2); // "12******90"
```

### Utility

```dart
YoStringFormatter.wordCount('Hello World');  // 2
YoStringFormatter.formatBoolean(true);       // "Ya"
YoStringFormatter.formatDuration(185);       // "03:05" (MM:SS)
YoStringFormatter.formatDurationLong(3725);  // "1 jam 2 menit"
```

---

## YoIdGenerator

### Basic IDs

| Method | Length | Example |
|--------|--------|---------|
| `numericId()` | 8 | "84729163" |
| `numericId(length: 12)` | 12 | "847291635820" |
| `alphanumericId()` | 12 | "A8k2Lm9xPq4R" |
| `uuid()` | 36 | "550e8400-e29b-41d4-a716-446655440000" |

```dart
YoIdGenerator.numericId();              // "84729163"
YoIdGenerator.numericId(length: 12);    // "847291635820"
YoIdGenerator.alphanumericId();         // "A8k2Lm9xPq4R"
YoIdGenerator.uuid();                   // "550e8400-e29b-41d4-a716-446655440000"
```

### Prefixed IDs

| Method | Prefix | Example |
|--------|--------|---------|
| `prefixedId('INV', length: 8)` | INV | "INV_12345678" |
| `userId()` | USR | "USR_12345678" |
| `orderId()` | ORD | "ORD_20260126847" |
| `transactionId()` | TRX | "TRX_12345678" |
| `productId()` | PROD | "PROD_12345678" |

```dart
YoIdGenerator.prefixedId('INV', length: 8);  // "INV_12345678"
YoIdGenerator.userId();                       // "USR_12345678"
YoIdGenerator.orderId();                      // "ORD_20260126847"
YoIdGenerator.transactionId();                // "TRX_12345678"
YoIdGenerator.productId();                    // "PROD_12345678"
```

### Timestamp-based

```dart
YoIdGenerator.timestampId();                      // "26012026143052"
YoIdGenerator.shortTimestampId();                 // "260126143052"
YoIdGenerator.timestampWithRandomId(randomLength: 4); // "26012026143052_8472"
```

### Hash-based

| Method | Length | Description |
|--------|--------|-------------|
| `md5Id(input)` | 32 | MD5 hash |
| `sha1Id(input)` | 40 | SHA1 hash |
| `sha256Id(input)` | 64 | SHA256 hash |
| `shortHashId(input, length)` | custom | Truncated hash |

```dart
YoIdGenerator.md5Id('input');            // 32-char MD5
YoIdGenerator.sha1Id('input');           // 40-char SHA1
YoIdGenerator.sha256Id('input');         // 64-char SHA256
YoIdGenerator.shortHashId('input', length: 8); // "0cc175b9"
```

### Sequential

```dart
YoIdGenerator.sequentialId('INV', 42, padding: 6);  // "INV_000042"
YoIdGenerator.autoIncrementId('ORD', 1);            // "ORD_20260126_001"
```

### Custom Format

| Method | Format/Example |
|--------|----------------|
| `customFormatId('XX-XXXX-XXXX')` | "A8-K2L9-MX4R" |
| `licenseKeyId()` | "A8K2-L9MX-4RPQ-5NBV" |
| `couponCode(prefix: 'SALE')` | "SALEA8K2L9" |

```dart
YoIdGenerator.customFormatId('XX-XXXX-XXXX');  // "A8-K2L9-MX4R"
YoIdGenerator.licenseKeyId();                   // "A8K2-L9MX-4RPQ-5NBV"
YoIdGenerator.couponCode(prefix: 'SALE');       // "SALEA8K2L9"
```

### Batch Generation

```dart
List<String> ids = YoIdGenerator.batchGenerate(count: 10, length: 8);
List<String> uniqueIds = YoIdGenerator.batchGenerateUnique(count: 10, prefix: 'USR');
```

### Validation

| Method | Description |
|--------|-------------|
| `isValidNumericId(id)` | Check if numeric only |
| `isValidUuid(id)` | Check UUID format |
| `isValidPrefixedId(id, prefix)` | Check prefix format |

```dart
YoIdGenerator.isValidNumericId('12345678');      // true
YoIdGenerator.isValidUuid('550e8400-...');       // true
YoIdGenerator.isValidPrefixedId('USR_123', 'USR'); // true
```

### Checksum

```dart
String id = YoIdGenerator.idWithChecksum('USR12345');  // "USR12345_A8"
bool valid = YoIdGenerator.verifyChecksum('USR12345_A8'); // true
```

---

## Text Input Formatters

### Usage with YoTextFormField

```dart
YoTextFormField(
  labelText: 'Field',
  inputFormatters: [FormatterClass()],
)
```

### IndonesiaCurrencyFormatter

| Parameter | Default | Description |
|-----------|---------|-------------|
| `showSymbol` | true | Show 'Rp ' prefix |

```dart
IndonesiaCurrencyFormatter()  // Input: 1500000 → Display: "Rp 1.500.000"
IndonesiaCurrencyFormatter(showSymbol: false)  // Display: "1.500.000"
```

### CurrencyTextInputFormatter

| Parameter | Default | Description |
|-----------|---------|-------------|
| `thousandSeparator` | '.' | Thousand separator |
| `decimalSeparator` | ',' | Decimal separator |
| `decimalDigits` | 0 | Decimal places |

```dart
CurrencyTextInputFormatter(
  thousandSeparator: '.',
  decimalSeparator: ',',
  decimalDigits: 2,
)  // Input: 1500000.50 → Display: "1.500.000,50"
```

### IndonesiaPhoneFormatter

```dart
IndonesiaPhoneFormatter()  // Input: 081234567890 → Display: "0812 3456 7890"
```

### CreditCardFormatter

| Parameter | Default | Description |
|-----------|---------|-------------|
| `separator` | ' ' | Digit group separator |

```dart
CreditCardFormatter()           // "1234 5678 9012 3456"
CreditCardFormatter(separator: '-')  // "1234-5678-9012-3456"
```

### Case Formatters

```dart
UpperCaseTextFormatter()  // "HELLO"
LowerCaseTextFormatter()  // "hello"
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
    String rawValue = value.replaceAll(RegExp(r'[^\d]'), '');
    int amount = int.tryParse(rawValue) ?? 0;
  },
)
```

---

## YoDeviceHelper

### Device Info

| Method | Returns | Description |
|--------|---------|-------------|
| `getDeviceInfo()` | Map<String, dynamic> | Full device info |
| `getPlatformType()` | PlatformType | Current platform enum |
| `getPlatformName()` | String | Platform name |

```dart
Map<String, dynamic> info = await YoDeviceHelper.getDeviceInfo();
// {'model': 'Pixel 6', 'brand': 'Google', 'osVersion': '14', ...}
```

### Platform Detection

| Property | Type | Description |
|----------|------|-------------|
| `isWeb` | bool | Is web platform |
| `isMobile` | bool | Is Android or iOS |
| `isDesktop` | bool | Is Windows, macOS, Linux |

```dart
PlatformType platform = YoDeviceHelper.getPlatformType(); // PlatformType.android
String name = YoDeviceHelper.getPlatformName();           // "Android"
bool isWeb = YoDeviceHelper.isWeb;
bool isMobile = YoDeviceHelper.isMobile;    // Android or iOS
bool isDesktop = YoDeviceHelper.isDesktop;  // Windows, macOS, Linux
```

### Screen Info

| Method | Returns | Description |
|--------|---------|-------------|
| `isTablet(context)` | bool | Device is tablet |
| `isPhone(context)` | bool | Device is phone |
| `getScreenSize(context)` | ScreenSize | small/medium/large |
| `isLandscape(context)` | bool | Landscape orientation |

```dart
bool isTablet = YoDeviceHelper.isTablet(context);
bool isPhone = YoDeviceHelper.isPhone(context);
ScreenSize size = YoDeviceHelper.getScreenSize(context);  // small/medium/large
bool isLandscape = YoDeviceHelper.isLandscape(context);
```

### Device Metrics

```dart
double ratio = YoDeviceHelper.getPixelRatio(context);
double scale = YoDeviceHelper.getTextScaleFactor(context);
EdgeInsets safeArea = YoDeviceHelper.getSafeAreaPadding(context);
```

### Notch & Navigation

```dart
bool hasNotch = YoDeviceHelper.hasNotch(context);
double notchHeight = YoDeviceHelper.getNotchHeight(context);
double navHeight = YoDeviceHelper.getBottomNavigationBarHeight(context);
double statusHeight = YoDeviceHelper.getStatusBarHeight(context);
```

### Keyboard

```dart
bool isVisible = YoDeviceHelper.isKeyboardVisible(context);
double height = YoDeviceHelper.getKeyboardHeight(context);
```

---

## YoConnectivity

### Setup (main.dart)

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await YoConnectivity.initialize();
  runApp(MyApp());
}
```

### Check Connection

| Property/Method | Returns | Description |
|-----------------|---------|-------------|
| `isConnected` | bool | Current connection state |
| `checkConnection()` | Future<bool> | Check and return state |
| `connectionName` | String | "WiFi" / "Mobile" / "None" |

```dart
bool isConnected = YoConnectivity.isConnected;
bool connected = await YoConnectivity.checkConnection();
String type = YoConnectivity.connectionName;  // "WiFi" / "Mobile" / "None"
```

### Listen to Changes

```dart
void onConnectionChanged(bool isConnected) {
  if (isConnected) print('Connected');
  else print('Disconnected');
}

YoConnectivity.addListener(onConnectionChanged);
YoConnectivity.removeListener(onConnectionChanged);
```

### Ensure Connection

| Parameter | Type | Description |
|-----------|------|-------------|
| `callback` | Future<T> Function() | API call to execute |
| `errorMessage` | String? | Custom error message |
| `timeout` | Duration? | Request timeout |

```dart
try {
  final result = await YoConnectivity.ensureConnection(
    () async => await api.fetchData(),
    errorMessage: 'No internet connection',
    timeout: Duration(seconds: 30),
  );
} on YoConnectionException catch (e) {
  print(e.message);
}
```

### Cleanup

```dart
YoConnectivity.dispose();
```

---

## YoLogger

### Log Levels

| Method | Color | Use Case |
|--------|-------|----------|
| `debug` | Cyan | Detailed debugging |
| `info` | Green | General info |
| `warning` | Yellow | Warnings |
| `error` | Red | Errors |
| `critical` | Magenta | Critical failures |

```dart
YoLogger.debug('Message', tag: 'API');    // Cyan - detailed debugging
YoLogger.info('Message');                  // Green - general info
YoLogger.warning('Message', tag: 'PERF'); // Yellow - warnings
YoLogger.error('Message', error: e, stackTrace: stack); // Red - errors
YoLogger.critical('Crashed!', error: e);  // Magenta - critical
```

### Configuration

| Method | Description |
|--------|-------------|
| `enable()` | Enable logging |
| `disable()` | Disable for production |
| `setLevel(level)` | Set minimum log level |

**YoLogLevel Values**: `debug`, `info`, `warning`, `error`, `critical`

```dart
YoLogger.enable();                       // Enable logging
YoLogger.disable();                      // Disable for production
YoLogger.setLevel(YoLogLevel.warning);   // Only warning+ shown
```

### Best Practice

```dart
void main() {
  if (kDebugMode) {
    YoLogger.enable();
    YoLogger.setLevel(YoLogLevel.debug);
  } else {
    YoLogger.disable();
  }
  runApp(MyApp());
}
```

### Output Format

```
[DEBUG] 14:30:52 [API] Fetching data
[INFO] 14:30:53 User logged in
[ERROR] 14:30:55 Failed to fetch
  Error: SocketException
  StackTrace: ...
```
