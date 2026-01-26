# YoUI Components Guide

Katalog lengkap widget siap pakai di YoUI. Setiap komponen didesain modern, responsif, dan mendukung tema Dark/Light otomatis.

---

## Table of Contents

- [Basic Components](#-basic-components)
- [Display Components](#-display-components)
- [Form Components](#-form-components)
- [Feedback Components](#-feedback-components)
- [Navigation Components](#-navigation-components)
- [Picker Components](#-picker-components)
- [Layout Components](#-layout-components)
- [Utility Components](#-utility-components)

---

## Basic Components

Komponen dasar yang sering digunakan di setiap halaman aplikasi.

### YoScaffold

Wrapper utama halaman yang terintegrasi dengan background tema YoUI.

```dart
YoScaffold(
  appBar: YoAppBar(title: 'Home'),
  body: Center(child: Text('Hello World')),
  floatingActionButton: FloatingActionButton(
    onPressed: () {},
    child: Icon(Icons.add),
  ),
)
```

### YoIconButton

Tombol berupa icon dengan efek splash yang rapi.

```dart
YoIconButton(
  icon: Icons.favorite,
  onPressed: () => print('Liked!'),
  color: context.errorColor,
  size: 24,
)
```

---

## Display Components

Komponen untuk menampilkan konten dan data kepada pengguna.

### YoAvatar

Widget avatar dengan dukungan gambar, inisial, atau icon.

**Constructors:**
- `YoAvatar()` - Default constructor
- `YoAvatar.icon()` - Avatar dengan icon
- `YoAvatar.image()` - Avatar dengan gambar
- `YoAvatar.text()` - Avatar dengan inisial teks

**Parameters:**

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `imageUrl` | `String?` | `null` | URL gambar avatar |
| `text` | `String?` | `null` | Teks untuk dikonversi ke inisial |
| `icon` | `IconData?` | `null` | Icon yang ditampilkan |
| `backgroundColor` | `Color?` | `null` | Warna background |
| `textColor` | `Color?` | `null` | Warna teks/inisial |
| `iconColor` | `Color?` | `null` | Warna icon |
| `size` | `YoAvatarSize` | `YoAvatarSize.md` | Ukuran preset (xs/sm/md/lg/xl) |
| `customSize` | `double?` | `null` | Ukuran kustom dalam pixel |
| `variant` | `YoAvatarVariant` | `circle` | Bentuk (circle/rounded/square) |
| `borderRadius` | `double?` | `null` | Custom border radius |
| `showBadge` | `bool` | `false` | Tampilkan badge status |
| `badgeColor` | `Color?` | `null` | Warna badge |
| `customBadge` | `Widget?` | `null` | Widget badge kustom |
| `onTap` | `VoidCallback?` | `null` | Callback saat ditekan |
| `borderWidth` | `double?` | `null` | Lebar border |
| `borderColor` | `Color?` | `null` | Warna border |

**Enums:**

```dart
enum YoAvatarSize { xs, sm, md, lg, xl }
enum YoAvatarVariant { circle, rounded, square }
```

**Contoh Penggunaan:**

```dart
// Avatar dengan gambar
YoAvatar.image(
  imageUrl: 'https://example.com/photo.jpg',
  size: YoAvatarSize.lg,
  showBadge: true,
  badgeColor: Colors.green,
)

// Avatar dengan inisial
YoAvatar.text(
  text: 'John Doe',
  backgroundColor: context.primaryColor,
  textColor: Colors.white,
)

// Avatar dengan icon
YoAvatar.icon(
  icon: Icons.person,
  size: YoAvatarSize.xl,
  variant: YoAvatarVariant.rounded,
)

// Avatar dengan ukuran kustom
YoAvatar(
  imageUrl: 'https://example.com/photo.jpg',
  customSize: 80, // 80 pixel
)
```

---

### YoAvatarOverlap

Menampilkan beberapa avatar yang saling tumpang tindih.

**Constructors:**
- `YoAvatarOverlap()` - Dengan list URL gambar
- `YoAvatarOverlap.custom()` - Dengan list YoAvatar widgets

**Parameters:**

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `imageUrls` | `List<String>` | required | List URL gambar avatar |
| `avatars` | `List<YoAvatar>?` | `null` | List avatar kustom (untuk .custom) |
| `overlap` | `double` | `0.3` | Rasio overlap (0-1) |
| `size` | `YoAvatarSize` | `md` | Ukuran avatar |
| `maxDisplay` | `int` | `4` | Maksimal avatar yang ditampilkan |
| `moreBuilder` | `Widget?` | `null` | Widget "+N" kustom |
| `onTapMore` | `VoidCallback?` | `null` | Callback saat "+N" ditekan |
| `variant` | `YoAvatarVariant` | `circle` | Bentuk avatar |

**Contoh Penggunaan:**

```dart
YoAvatarOverlap(
  imageUrls: [
    'https://example.com/user1.jpg',
    'https://example.com/user2.jpg',
    'https://example.com/user3.jpg',
    'https://example.com/user4.jpg',
    'https://example.com/user5.jpg',
  ],
  maxDisplay: 3,
  size: YoAvatarSize.sm,
  onTapMore: () => showAllMembers(),
)
```

---

### YoAccordion

Widget accordion sederhana dengan expand/collapse.

**Parameters:**

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `title` | `String` | required | Judul accordion |
| `content` | `Widget` | required | Konten yang dapat di-expand |
| `initiallyExpanded` | `bool` | `false` | Status awal expanded |
| `padding` | `EdgeInsetsGeometry?` | `null` | Padding konten |
| `backgroundColor` | `Color?` | `null` | Warna background |
| `borderColor` | `Color?` | `null` | Warna border |
| `borderRadius` | `double` | `8.0` | Border radius |

**Contoh Penggunaan:**

```dart
YoAccordion(
  title: 'FAQ: Bagaimana cara pembayaran?',
  content: Padding(
    padding: EdgeInsets.all(16),
    child: Text('Anda dapat membayar menggunakan transfer bank, e-wallet, atau kartu kredit.'),
  ),
  initiallyExpanded: false,
)
```

---

### YoExpansionPanel

Panel expansion dengan fitur lebih lengkap dan animasi.

**Constructors:**
- `YoExpansionPanel()` - Single panel
- `YoExpansionPanelList()` - List dengan mode accordion

**Parameters (YoExpansionPanel):**

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `header` | `Widget` | required | Widget header |
| `body` | `Widget` | required | Widget konten |
| `initiallyExpanded` | `bool` | `false` | Status awal |
| `onExpansionChanged` | `Function(bool)?` | `null` | Callback perubahan |
| `animationDuration` | `Duration` | `200ms` | Durasi animasi |
| `contentPadding` | `EdgeInsetsGeometry?` | `null` | Padding konten |
| `backgroundColor` | `Color?` | `null` | Warna background |
| `expandedBackgroundColor` | `Color?` | `null` | Warna saat expanded |

**Parameters (YoExpansionPanelList):**

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `children` | `List<YoExpansionPanelItem>` | required | List panel items |
| `onExpansionChanged` | `Function(int, bool)?` | `null` | Callback dengan index |
| `expandOnlyOne` | `bool` | `false` | Mode accordion (satu panel terbuka) |
| `dividerColor` | `Color?` | `null` | Warna divider |
| `elevation` | `double` | `0` | Elevasi material |

**Contoh Penggunaan:**

```dart
YoExpansionPanelList(
  expandOnlyOne: true, // Mode accordion
  children: [
    YoExpansionPanelItem(
      header: Text('Section 1'),
      body: Text('Content for section 1'),
    ),
    YoExpansionPanelItem(
      header: Text('Section 2'),
      body: Text('Content for section 2'),
    ),
  ],
)
```

---

### YoBadge

Badge untuk status, label, dan notifikasi.

**Constructors:**
- `YoBadge()` - Default
- `YoBadge.primary()` - Varian primary
- `YoBadge.secondary()` - Varian secondary
- `YoBadge.success()` - Varian hijau
- `YoBadge.warning()` - Varian oranye
- `YoBadge.error()` - Varian merah
- `YoBadge.outline()` - Varian outlined
- `YoBadge.dot()` - Hanya titik notifikasi

**Parameters:**

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `text` | `String` | required | Teks badge |
| `variant` | `YoBadgeVariant` | `primary` | Varian style |
| `size` | `YoBadgeSize` | `medium` | Ukuran badge |
| `icon` | `Widget?` | `null` | Icon widget |
| `iconPosition` | `IconPosition` | `left` | Posisi icon |
| `backgroundColor` | `Color?` | `null` | Warna background |
| `textColor` | `Color?` | `null` | Warna teks |
| `showDot` | `bool` | `false` | Tampilkan dot status |
| `dotColor` | `Color?` | `null` | Warna dot |
| `onTap` | `VoidCallback?` | `null` | Callback tap |

**Enums:**

```dart
enum YoBadgeVariant { primary, secondary, success, warning, error, outline }
enum YoBadgeSize { small, medium, large }
```

**Contoh Penggunaan:**

```dart
// Badge status
YoBadge.success(text: 'Active')

// Badge dengan icon
YoBadge(
  text: 'New',
  icon: Icon(Icons.star, size: 12),
  variant: YoBadgeVariant.primary,
)

// Badge error
YoBadge.error(text: 'Failed')
```

---

### YoChip

Chip widget untuk tags, filters, dan kategori.

**Constructors:**
- `YoChip()` - Default
- `YoChip.primary()` - Primary color
- `YoChip.success()` - Success/green
- `YoChip.error()` - Error/red
- `YoChip.warning()` - Warning/orange
- `YoChip.info()` - Info/blue

**Parameters:**

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `label` | `String` | required | Label chip |
| `variant` | `YoChipVariant` | `filled` | Style varian |
| `size` | `YoChipSize` | `medium` | Ukuran |
| `backgroundColor` | `Color?` | `null` | Warna background |
| `textColor` | `Color?` | `null` | Warna teks |
| `borderColor` | `Color?` | `null` | Warna border |
| `borderRadius` | `double?` | `null` | Border radius |
| `leading` | `Widget?` | `null` | Widget di depan |
| `trailing` | `Widget?` | `null` | Widget di belakang |
| `onTap` | `VoidCallback?` | `null` | Callback tap |
| `onDeleted` | `VoidCallback?` | `null` | Callback delete (tampilkan X) |
| `selected` | `bool` | `false` | Status terpilih |

**Enums:**

```dart
enum YoChipVariant { filled, outlined, tonal }
enum YoChipSize { small, medium, large }
```

**Contoh Penggunaan:**

```dart
// Chip dengan delete
YoChip(
  label: 'Flutter',
  onDeleted: () => removeTag('Flutter'),
)

// Chip selectable
YoChip(
  label: 'Category A',
  selected: isSelected,
  onTap: () => toggleSelection(),
)

// Preset chips
Wrap(
  spacing: 8,
  children: [
    YoChip.success(label: 'Completed'),
    YoChip.warning(label: 'Pending'),
    YoChip.error(label: 'Failed'),
  ],
)
```

---

### YoRating

Widget rating dengan berbagai tipe dan mode interaktif.

**Constructors:**
- `YoRating()` - Rating interaktif utama
- `YoRatingStars()` - Rating bintang read-only
- `YoRatingInteractive()` - Rating interaktif dengan label
- `YoRatingSummary()` - Ringkasan rating dengan breakdown

**Parameters (YoRating):**

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `initialRating` | `double` | `0.0` | Nilai rating awal |
| `maxRating` | `int` | `5` | Rating maksimal |
| `onRatingUpdate` | `ValueChanged<double>?` | `null` | Callback perubahan |
| `allowHalfRating` | `bool` | `false` | Izinkan setengah rating |
| `size` | `YoRatingSize` | `medium` | Ukuran |
| `type` | `YoRatingType` | `stars` | Tipe rating |
| `color` | `Color?` | `null` | Warna aktif |
| `backgroundColor` | `Color?` | `null` | Warna inaktif |
| `readOnly` | `bool` | `false` | Mode read-only |
| `showLabel` | `bool` | `false` | Tampilkan label |
| `spacing` | `double` | `4.0` | Jarak antar icon |
| `animate` | `bool` | `true` | Aktifkan animasi |

**Parameters (YoRatingSummary):**

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `rating` | `double` | required | Rata-rata rating |
| `totalRatings` | `int` | required | Total jumlah rating |
| `showBreakdown` | `bool` | `false` | Tampilkan distribusi |
| `ratingsDistribution` | `List<int>?` | `null` | Jumlah rating per level |

**Enums:**

```dart
enum YoRatingSize { small, medium, large, xlarge }
enum YoRatingType { stars, hearts, emojis, numbers, custom }
```

**Contoh Penggunaan:**

```dart
// Rating interaktif
YoRating(
  initialRating: 3.5,
  allowHalfRating: true,
  onRatingUpdate: (rating) => saveRating(rating),
)

// Rating summary
YoRatingSummary(
  rating: 4.2,
  totalRatings: 1250,
  showBreakdown: true,
  ratingsDistribution: [50, 120, 280, 400, 400],
)

// Rating dengan tipe hearts
YoRating(
  type: YoRatingType.hearts,
  maxRating: 5,
  color: Colors.red,
)
```

---

### YoText

Widget teks dengan style typography Material Design.

**Static Factory Methods:**
- `YoText.displayLarge()` / `displayMedium()` / `displaySmall()`
- `YoText.headlineLarge()` / `headlineMedium()` / `headlineSmall()`
- `YoText.titleLarge()` / `titleMedium()` / `titleSmall()`
- `YoText.bodyLarge()` / `bodyMedium()` / `bodySmall()`
- `YoText.labelLarge()` / `labelMedium()` / `labelSmall()`
- `YoText.monoLarge()` / `monoMedium()` / `monoSmall()`

**Parameters (semua methods):**

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `text` | `String` | required | Konten teks |
| `align` | `TextAlign?` | `null` | Alignment teks |
| `maxLines` | `int?` | `null` | Maksimal baris |
| `overflow` | `TextOverflow?` | `null` | Overflow behavior |
| `softWrap` | `bool?` | `true` | Soft wrap |
| `color` | `Color?` | `null` | Override warna |
| `fontWeight` | `FontWeight?` | `null` | Override weight |
| `fontSize` | `double?` | `null` | Override ukuran |

**Contoh Penggunaan:**

```dart
Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    YoText.headlineMedium('Welcome Back'),
    YoText.bodyLarge('Here is your dashboard overview'),
    YoText.monoMedium('Order #ORD-20260126-001'),
    YoText.labelSmall('Last updated: 5 minutes ago', color: context.gray500),
  ],
)
```

---

### YoExpandableText

Teks yang dapat di-expand dengan "Show More/Less".

**Parameters:**

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `text` | `String` | required | Konten teks |
| `maxLines` | `int` | `3` | Maks baris sebelum terpotong |
| `expandText` | `String` | `'Show more'` | Teks tombol expand |
| `collapseText` | `String` | `'Show less'` | Teks tombol collapse |
| `textStyle` | `TextStyle?` | `null` | Style teks |
| `linkStyle` | `TextStyle?` | `null` | Style link |
| `textAlign` | `TextAlign` | `start` | Alignment |
| `expanded` | `bool` | `false` | Status awal |

**Contoh Penggunaan:**

```dart
YoExpandableText(
  text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
        'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. '
        'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris.',
  maxLines: 2,
  expandText: 'Lihat selengkapnya',
  collapseText: 'Sembunyikan',
)
```

---

### YoTooltip

Tooltip dengan integrasi tema.

**Parameters:**

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `message` | `String` | required | Pesan tooltip |
| `child` | `Widget` | required | Widget child |
| `padding` | `EdgeInsetsGeometry?` | `null` | Padding tooltip |
| `borderRadius` | `double` | `8.0` | Border radius |
| `backgroundColor` | `Color?` | `null` | Warna background |
| `textColor` | `Color?` | `null` | Warna teks |
| `waitDuration` | `Duration` | `500ms` | Delay sebelum muncul |
| `preferBelow` | `bool` | `true` | Posisi di bawah |

**Contoh Penggunaan:**

```dart
YoTooltip(
  message: 'Klik untuk mengedit profil',
  child: IconButton(
    icon: Icon(Icons.edit),
    onPressed: () => editProfile(),
  ),
)
```

---

### YoCarousel

Slider/carousel dengan auto-play dan indikator.

**Parameters:**

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `items` | `List<Widget>` | required | Item carousel |
| `height` | `double` | `200` | Tinggi carousel |
| `autoPlay` | `bool` | `false` | Auto-play aktif |
| `autoPlayInterval` | `Duration` | `3s` | Interval auto-play |
| `showIndicators` | `bool` | `true` | Tampilkan indikator |
| `infiniteScroll` | `bool` | `true` | Scroll tak terbatas |
| `viewportFraction` | `double` | `1.0` | Fraksi viewport |
| `borderRadius` | `BorderRadius?` | `null` | Border radius item |
| `padding` | `EdgeInsetsGeometry?` | `null` | Padding item |
| `onPageChanged` | `ValueChanged<int>?` | `null` | Callback page change |

**Contoh Penggunaan:**

```dart
YoCarousel(
  height: 200,
  autoPlay: true,
  autoPlayInterval: Duration(seconds: 5),
  items: [
    Image.network('https://example.com/banner1.jpg', fit: BoxFit.cover),
    Image.network('https://example.com/banner2.jpg', fit: BoxFit.cover),
    Image.network('https://example.com/banner3.jpg', fit: BoxFit.cover),
  ],
  onPageChanged: (index) => print('Page: $index'),
)
```

---

### YoTimeline

Timeline untuk menampilkan urutan kejadian atau progres.

**Constructors:**
- `YoTimeline()` - Default timeline
- `YoTimeline.stepper()` - Stepper style dengan nomor

**Parameters:**

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `events` | `List<YoTimelineEvent>` | required | List event |
| `direction` | `YoTimelineDirection` | `vertical` | Arah timeline |
| `lineColor` | `Color?` | `null` | Warna garis penghubung |
| `activeColor` | `Color?` | `null` | Warna item aktif |
| `completedColor` | `Color?` | `null` | Warna item selesai |
| `lineWidth` | `double` | `2.0` | Lebar garis |
| `dotSize` | `double` | `24.0` | Ukuran dot |
| `showConnector` | `bool` | `true` | Tampilkan connector |
| `alternating` | `bool` | `false` | Sisi bergantian (vertical) |
| `shrinkWrap` | `bool` | `true` | Shrink wrap |

**YoTimelineEvent Model:**

| Property | Type | Description |
|----------|------|-------------|
| `title` | `String` | Judul event |
| `subtitle` | `String?` | Subtitle |
| `description` | `String?` | Deskripsi |
| `date` | `DateTime?` | Tanggal event |
| `icon` | `IconData?` | Icon kustom |
| `color` | `Color?` | Warna dot |
| `customDot` | `Widget?` | Dot kustom |
| `actions` | `List<Widget>?` | Action widgets |
| `isCompleted` | `bool` | Status selesai |
| `isActive` | `bool` | Status aktif |

**Contoh Penggunaan:**

```dart
YoTimeline(
  events: [
    YoTimelineEvent(
      title: 'Order Placed',
      description: 'Your order has been received',
      date: DateTime(2026, 1, 25, 10, 30),
      isCompleted: true,
    ),
    YoTimelineEvent(
      title: 'Processing',
      description: 'Your order is being prepared',
      isActive: true,
    ),
    YoTimelineEvent(
      title: 'Shipped',
      description: 'On the way to your address',
    ),
    YoTimelineEvent(
      title: 'Delivered',
      description: 'Package delivered',
    ),
  ],
)
```

---

### YoChart

Komponen grafik menggunakan fl_chart.

**Constructors:**
- `YoLineChart()` - Grafik garis
- `YoLineChart.simple()` - Grafik garis sederhana
- `YoBarChart()` - Grafik batang
- `YoPieChart()` - Grafik pie
- `YoPieChart.donut()` - Grafik donut
- `YoSparkLine()` - Mini sparkline

**Parameters (YoLineChart):**

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `dataSets` | `List<List<YoChartData>>` | required | Multiple data series |
| `lineColors` | `List<Color>?` | `null` | Warna garis |
| `legends` | `List<String>?` | `null` | Label legend |
| `title` | `String?` | `null` | Judul chart |
| `showGrid` | `bool` | `true` | Tampilkan grid |
| `showDots` | `bool` | `true` | Tampilkan titik data |
| `curved` | `bool` | `true` | Garis melengkung |
| `filled` | `bool` | `false` | Isi area di bawah garis |
| `height` | `double` | `200` | Tinggi chart |
| `formatX` | `String Function(double)?` | `null` | Format sumbu X |
| `formatY` | `String Function(double)?` | `null` | Format sumbu Y |

**Parameters (YoPieChart):**

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `data` | `List<YoPieData>` | required | Data pie |
| `colors` | `List<Color>?` | `null` | Warna slice |
| `title` | `String?` | `null` | Judul chart |
| `centerText` | `String?` | `null` | Teks tengah (donut) |
| `donut` | `bool` | `false` | Style donut |
| `size` | `double` | `200` | Ukuran chart |
| `showLabels` | `bool` | `true` | Tampilkan label |
| `showPercentage` | `bool` | `true` | Tampilkan persentase |
| `showLegend` | `bool` | `true` | Tampilkan legend |

**Contoh Penggunaan:**

```dart
// Line Chart
YoLineChart(
  title: 'Revenue 2026',
  dataSets: [
    [
      YoChartData(x: 1, y: 1000, label: 'Jan'),
      YoChartData(x: 2, y: 1500, label: 'Feb'),
      YoChartData(x: 3, y: 1200, label: 'Mar'),
    ],
  ],
  curved: true,
  filled: true,
)

// Pie Chart
YoPieChart.donut(
  centerText: '75%',
  data: [
    YoPieData(value: 40, label: 'Product A'),
    YoPieData(value: 30, label: 'Product B'),
    YoPieData(value: 20, label: 'Product C'),
    YoPieData(value: 10, label: 'Others'),
  ],
)

// Sparkline (mini chart)
YoSparkLine(
  data: [10, 25, 18, 30, 22, 35, 28],
  height: 40,
  width: 120,
  color: context.successColor,
)
```

---

### YoDataTable

Tabel data dengan sorting dan scroll horizontal.

**Parameters:**

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `columns` | `List<YoTableColumn>` | required | Definisi kolom |
| `rows` | `List<YoTableRow>` | required | Data baris |
| `onSort` | `Function(int, bool)?` | `null` | Callback sorting |
| `selectable` | `bool` | `false` | Aktifkan seleksi baris |
| `onSelectionChanged` | `Function(List<int>)?` | `null` | Callback seleksi |
| `rowHeight` | `double` | `52` | Tinggi baris |
| `showHeader` | `bool` | `true` | Tampilkan header |
| `headerColor` | `Color?` | `null` | Warna header |
| `rowColor` | `Color?` | `null` | Warna baris |
| `alternateRowColor` | `Color?` | `null` | Warna baris alternatif |

**Contoh Penggunaan:**

```dart
YoDataTable(
  columns: [
    YoTableColumn(label: 'ID', width: 80, sortable: true),
    YoTableColumn(label: 'Name', sortable: true),
    YoTableColumn(label: 'Price', numeric: true),
    YoTableColumn(label: 'Stock', numeric: true),
  ],
  rows: products.map((p) => YoTableRow(
    cells: [p.id, p.name, p.price.toString(), p.stock.toString()],
    onTap: () => viewProduct(p),
  )).toList(),
  selectable: true,
  onSort: (columnIndex, ascending) => sortProducts(columnIndex, ascending),
)
```

---

### YoCalendar

Widget kalender dengan view harian, mingguan, dan bulanan.

**Parameters:**

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `events` | `List<YoCalendarEvent>` | required | List event kalender |
| `initialView` | `YoCalendarView` | `monthly` | View awal |
| `initialDate` | `DateTime?` | `null` | Tanggal awal |
| `onDateSelected` | `Function(DateTime)?` | `null` | Callback pilih tanggal |
| `onEventTap` | `Function(YoCalendarEvent)?` | `null` | Callback tap event |
| `onRangeChanged` | `Function(DateTime, DateTime)?` | `null` | Callback range berubah |
| `showViewSelector` | `bool` | `true` | Tampilkan selector view |
| `showNavigation` | `bool` | `true` | Tampilkan navigasi |
| `title` | `String?` | `null` | Judul kalender |

**Enums:**

```dart
enum YoCalendarView { daily, weekly, monthly }
```

**Contoh Penggunaan:**

```dart
YoCalendar(
  events: [
    YoCalendarEvent(
      id: '1',
      title: 'Team Meeting',
      startTime: DateTime(2026, 1, 26, 10, 0),
      endTime: DateTime(2026, 1, 26, 11, 0),
      color: Colors.blue,
    ),
    YoCalendarEvent(
      id: '2',
      title: 'Project Deadline',
      startTime: DateTime(2026, 1, 28, 0, 0),
      endTime: DateTime(2026, 1, 28, 23, 59),
      isAllDay: true,
      color: Colors.red,
    ),
  ],
  onEventTap: (event) => showEventDetails(event),
)
```

---

### YoKanbanBoard

Papan kanban dengan drag-and-drop.

**Parameters:**

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `columns` | `List<YoKanbanColumn>` | required | Kolom kanban |
| `onItemMoved` | `Function(item, from, to)?` | `null` | Callback item dipindah |
| `onItemTap` | `Function(item, columnId)?` | `null` | Callback tap item |
| `onColumnTap` | `Function(column)?` | `null` | Callback tap kolom |
| `columnWidth` | `double` | `280` | Lebar kolom |
| `columnSpacing` | `double` | `16` | Jarak antar kolom |
| `scrollable` | `bool` | `true` | Scroll horizontal |
| `height` | `double` | `400` | Tinggi board |
| `dragEnabled` | `bool` | `true` | Aktifkan drag-drop |

**Contoh Penggunaan:**

```dart
YoKanbanBoard(
  height: 500,
  columns: [
    YoKanbanColumn(
      id: 'todo',
      title: 'To Do',
      color: Colors.grey,
      items: [
        YoKanbanItem(id: '1', title: 'Design UI', priority: 1),
        YoKanbanItem(id: '2', title: 'Write docs', priority: 2),
      ],
    ),
    YoKanbanColumn(
      id: 'progress',
      title: 'In Progress',
      color: Colors.blue,
      items: [
        YoKanbanItem(id: '3', title: 'Implement API', priority: 1),
      ],
    ),
    YoKanbanColumn(
      id: 'done',
      title: 'Done',
      color: Colors.green,
      items: [],
    ),
  ],
  onItemMoved: (item, fromColumn, toColumn) {
    print('Moved ${item.title} from $fromColumn to $toColumn');
  },
)
```

---

### YoChatBubble

Balon chat untuk aplikasi messaging.

**Constructors:**
- `YoChatBubble()` - Single bubble
- `YoChatList()` - List chat messages

**Parameters (YoChatBubble):**

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `message` | `YoChatMessage` | required | Data pesan |
| `onTap` | `Function(YoChatMessage)?` | `null` | Callback tap |
| `onLongPress` | `Function(YoChatMessage)?` | `null` | Callback long press |
| `showAvatar` | `bool` | `true` | Tampilkan avatar |
| `showTimestamp` | `bool` | `true` | Tampilkan timestamp |
| `showStatus` | `bool` | `true` | Tampilkan status delivery |
| `sentColor` | `Color?` | `null` | Warna bubble terkirim |
| `receivedColor` | `Color?` | `null` | Warna bubble diterima |

**Enums:**

```dart
enum YoMessageStatus { sending, sent, delivered, read, failed }
enum YoMessageType { text, image, file, system }
```

**Contoh Penggunaan:**

```dart
YoChatList(
  messages: [
    YoChatMessage(
      id: '1',
      text: 'Hello! How are you?',
      timestamp: DateTime.now().subtract(Duration(minutes: 5)),
      isSentByMe: false,
      senderName: 'John',
      senderAvatar: 'https://example.com/john.jpg',
    ),
    YoChatMessage(
      id: '2',
      text: 'I am good, thanks!',
      timestamp: DateTime.now(),
      isSentByMe: true,
      status: YoMessageStatus.read,
    ),
  ],
  onMessageLongPress: (msg) => showMessageOptions(msg),
)
```

---

### YoComment

Widget komentar dengan dukungan replies.

**Constructors:**
- `YoCommentWidget()` - Single comment
- `YoCommentList()` - List of comments

**Parameters (YoCommentWidget):**

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `comment` | `YoComment` | required | Data komentar |
| `compact` | `bool` | `false` | Mode compact |
| `onLike` | `Function(YoComment)?` | `null` | Callback like |
| `onReply` | `Function(YoComment)?` | `null` | Callback reply |
| `onEdit` | `Function(YoComment)?` | `null` | Callback edit |
| `onDelete` | `Function(YoComment)?` | `null` | Callback delete |
| `showReplies` | `bool` | `true` | Tampilkan replies |
| `maxReplyDepth` | `int` | `3` | Kedalaman reply maksimal |

**Contoh Penggunaan:**

```dart
YoCommentList(
  comments: [
    YoComment(
      id: '1',
      userAvatar: 'https://example.com/user1.jpg',
      userName: 'Alice',
      text: 'Great article! Very helpful.',
      timestamp: DateTime.now().subtract(Duration(hours: 2)),
      likes: 15,
      isLiked: false,
      replies: [
        YoComment(
          id: '2',
          userName: 'Bob',
          text: 'I agree!',
          timestamp: DateTime.now().subtract(Duration(hours: 1)),
        ),
      ],
    ),
  ],
  onLike: (comment) => likeComment(comment.id),
  onReply: (comment) => showReplyDialog(comment),
)
```

---

### YoProductCard

Kartu produk untuk e-commerce dan POS.

**Constructors:**
- `YoProductCard()` / `YoProductCard.grid()` - Kartu grid vertikal
- `YoProductCard.list()` - Kartu list horizontal
- `YoProductCard.pos()` - Kartu POS compact

**Parameters:**

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `imageUrl` | `String?` | `null` | URL gambar produk |
| `title` | `String` | required | Nama produk |
| `price` | `double` | required | Harga produk |
| `subtitle` | `String?` | `null` | Subtitle |
| `originalPrice` | `double?` | `null` | Harga asli (untuk diskon) |
| `rating` | `double?` | `null` | Rating produk |
| `reviewCount` | `int?` | `null` | Jumlah review |
| `stock` | `int?` | `null` | Jumlah stok |
| `badge` | `String?` | `null` | Badge text (Sale, New) |
| `badgeColor` | `Color?` | `null` | Warna badge |
| `isFavorite` | `bool` | `false` | Status favorit |
| `onTap` | `VoidCallback?` | `null` | Callback tap |
| `onFavorite` | `VoidCallback?` | `null` | Callback favorit |
| `onAddToCart` | `VoidCallback?` | `null` | Callback add to cart |
| `currencySymbol` | `String` | `'$'` | Simbol mata uang |
| `showStock` | `bool` | `false` | Tampilkan indikator stok |

**Contoh Penggunaan:**

```dart
// Grid view
YoProductCard.grid(
  imageUrl: 'https://example.com/product.jpg',
  title: 'Wireless Headphones',
  price: 99.99,
  originalPrice: 149.99,
  rating: 4.5,
  reviewCount: 128,
  badge: 'Sale',
  badgeColor: Colors.red,
  onTap: () => viewProduct(),
  onAddToCart: () => addToCart(),
  onFavorite: () => toggleFavorite(),
)

// POS view
YoProductCard.pos(
  title: 'Coffee Latte',
  price: 25000,
  currencySymbol: 'Rp ',
  stock: 50,
  showStock: true,
  onTap: () => addToOrder(),
)
```

---

### YoArticleCard

Kartu artikel/blog dengan berbagai layout.

**Constructors:**
- `YoArticleCard()` - Kartu vertikal default
- `YoArticleCard.horizontal()` - Kartu list horizontal
- `YoArticleCard.featured()` - Kartu featured dengan overlay

**Parameters:**

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `imageUrl` | `String?` | `null` | URL gambar artikel |
| `title` | `String` | required | Judul artikel |
| `excerpt` | `String?` | `null` | Ringkasan artikel |
| `category` | `String?` | `null` | Kategori |
| `authorName` | `String?` | `null` | Nama penulis |
| `authorAvatar` | `String?` | `null` | Avatar penulis |
| `publishedAt` | `DateTime?` | `null` | Tanggal publish |
| `readTime` | `int?` | `null` | Waktu baca (menit) |
| `isBookmarked` | `bool` | `false` | Status bookmark |
| `onTap` | `VoidCallback?` | `null` | Callback tap |
| `onBookmark` | `VoidCallback?` | `null` | Callback bookmark |
| `onShare` | `VoidCallback?` | `null` | Callback share |

**Contoh Penggunaan:**

```dart
YoArticleCard.featured(
  imageUrl: 'https://example.com/article.jpg',
  title: 'The Future of Flutter Development',
  excerpt: 'Explore the latest trends and best practices...',
  category: 'Technology',
  authorName: 'Jane Doe',
  authorAvatar: 'https://example.com/jane.jpg',
  publishedAt: DateTime.now().subtract(Duration(days: 2)),
  readTime: 8,
  onTap: () => readArticle(),
  onBookmark: () => toggleBookmark(),
)
```

---

### YoProfileCard

Kartu profil untuk aplikasi sosial.

**Constructors:**
- `YoProfileCard()` - Default dengan stats dan actions
- `YoProfileCard.compact()` - Compact horizontal
- `YoProfileCard.cover()` - Large dengan cover image

**Parameters:**

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `avatarUrl` | `String?` | `null` | URL avatar |
| `name` | `String` | required | Nama user |
| `subtitle` | `String?` | `null` | Subtitle/username |
| `bio` | `String?` | `null` | Bio user |
| `stats` | `List<YoProfileStat>` | `[]` | Statistik profil |
| `isVerified` | `bool` | `false` | Badge verified |
| `isFollowing` | `bool` | `false` | Status following |
| `onTap` | `VoidCallback?` | `null` | Callback tap |
| `onFollow` | `VoidCallback?` | `null` | Callback follow |
| `onMessage` | `VoidCallback?` | `null` | Callback message |

**Contoh Penggunaan:**

```dart
YoProfileCard(
  avatarUrl: 'https://example.com/user.jpg',
  name: 'John Doe',
  subtitle: '@johndoe',
  bio: 'Flutter developer | Tech enthusiast',
  isVerified: true,
  stats: [
    YoProfileStat(value: '1.2K', label: 'Posts'),
    YoProfileStat(value: '50K', label: 'Followers'),
    YoProfileStat(value: '200', label: 'Following'),
  ],
  onFollow: () => toggleFollow(),
  onMessage: () => openChat(),
)
```

---

### YoDestinationCard

Kartu destinasi untuk aplikasi travel.

**Constructors:**
- `YoDestinationCard()` - Default vertikal
- `YoDestinationCard.featured()` - Featured dengan overlay
- `YoDestinationCard.compact()` - Compact horizontal

**Parameters:**

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `imageUrl` | `String` | required | URL gambar |
| `title` | `String` | required | Nama destinasi |
| `location` | `String` | required | Lokasi |
| `rating` | `double?` | `null` | Rating |
| `reviewCount` | `int?` | `null` | Jumlah review |
| `price` | `double?` | `null` | Harga |
| `priceLabel` | `String?` | `null` | Label harga (per night) |
| `duration` | `String?` | `null` | Durasi |
| `tags` | `List<String>` | `[]` | Tags/features |
| `isFavorite` | `bool` | `false` | Status favorit |
| `onTap` | `VoidCallback?` | `null` | Callback tap |
| `onFavorite` | `VoidCallback?` | `null` | Callback favorit |
| `currencySymbol` | `String` | `'$'` | Simbol mata uang |

**Contoh Penggunaan:**

```dart
YoDestinationCard.featured(
  imageUrl: 'https://example.com/bali.jpg',
  title: 'Bali Paradise Resort',
  location: 'Bali, Indonesia',
  rating: 4.8,
  reviewCount: 524,
  price: 150,
  priceLabel: 'per night',
  tags: ['Beach', 'Pool', 'Spa'],
  isFavorite: true,
  onTap: () => viewDestination(),
)
```

---

### YoListTile

ListTile enhanced dengan berbagai varian.

**Constructors:**
- `YoListTile()` - Full-featured
- `YoListTile.simple()` - Simplified
- `YoListTileWithAvatar()` - Dengan avatar
- `YoListTileWithSwitch()` - Dengan switch toggle

**Parameters (YoListTile):**

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `leading` | `Widget?` | `null` | Widget di depan |
| `title` | `String?` | `null` | Teks judul |
| `titleWidget` | `Widget?` | `null` | Widget judul kustom |
| `subtitle` | `String?` | `null` | Teks subtitle |
| `subtitleWidget` | `Widget?` | `null` | Widget subtitle kustom |
| `trailing` | `Widget?` | `null` | Widget di belakang |
| `onTap` | `VoidCallback?` | `null` | Callback tap |
| `onLongPress` | `VoidCallback?` | `null` | Callback long press |
| `enabled` | `bool` | `true` | Status enabled |
| `selected` | `bool` | `false` | Status selected |
| `dense` | `bool` | `false` | Mode dense |
| `isThreeLine` | `bool` | `false` | Mode tiga baris |

**Parameters (YoListTileWithAvatar):**

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `imageUrl` | `String` | required | URL avatar |
| `title` | `String` | required | Judul |
| `subtitle` | `String?` | `null` | Subtitle |
| `timestamp` | `String?` | `null` | Timestamp |
| `hasUnread` | `bool` | `false` | Indikator unread |
| `isOnline` | `bool` | `false` | Status online |

**Contoh Penggunaan:**

```dart
// Settings tile with switch
YoListTileWithSwitch(
  title: 'Dark Mode',
  subtitle: 'Enable dark theme',
  icon: Icons.dark_mode,
  value: isDarkMode,
  onChanged: (value) => toggleDarkMode(value),
)

// Chat list tile
YoListTileWithAvatar(
  imageUrl: 'https://example.com/user.jpg',
  title: 'John Doe',
  subtitle: 'Hello! How are you?',
  timestamp: '2m ago',
  hasUnread: true,
  isOnline: true,
  onTap: () => openChat(),
)
```

---

## Form Components

Komponen input dan formulir.

### YoTextFormField

Input teks dengan berbagai style dan validasi bawaan.

**Parameters:**

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `labelText` | `String?` | `null` | Label field |
| `hintText` | `String?` | `null` | Hint placeholder |
| `initialValue` | `String?` | `null` | Nilai awal |
| `controller` | `TextEditingController?` | `null` | Controller eksternal |
| `inputType` | `YoInputType` | `text` | Tipe input |
| `inputStyle` | `YoInputStyle` | `outlined` | Style visual |
| `enabled` | `bool` | `true` | Status enabled |
| `readOnly` | `bool` | `false` | Status read-only |
| `obscureText` | `bool` | `false` | Sembunyikan teks |
| `autofocus` | `bool` | `false` | Auto-focus |
| `maxLines` | `int?` | `1` | Maksimal baris |
| `maxLength` | `int?` | `null` | Maksimal karakter |
| `borderRadius` | `double` | `12.0` | Border radius |
| `fillColor` | `Color?` | `null` | Warna fill |
| `borderColor` | `Color?` | `null` | Warna border |
| `focusedBorderColor` | `Color?` | `null` | Warna border fokus |
| `prefixIcon` | `Widget?` | `null` | Icon prefix |
| `suffixIcon` | `Widget?` | `null` | Icon suffix |
| `validator` | `String? Function(String?)?` | `null` | Custom validator |
| `onChanged` | `void Function(String)?` | `null` | Callback perubahan |
| `onSubmitted` | `void Function(String)?` | `null` | Callback submit |
| `showClearButton` | `bool` | `false` | Tampilkan tombol clear |
| `showVisibilityToggle` | `bool` | `false` | Toggle visibility password |
| `showCharacterCounter` | `bool` | `false` | Tampilkan counter karakter |
| `isRequired` | `bool` | `false` | Tandai sebagai required |
| `helperText` | `String?` | `null` | Teks helper |
| `errorText` | `String?` | `null` | Teks error |
| `inputFormatters` | `List<TextInputFormatter>?` | `null` | Input formatters |

**Enums:**

```dart
enum YoInputStyle { outlined, filled, underline, floating, modern, none }
enum YoInputType { text, email, password, phone, number, url, search, multiline, currency }
```

**Contoh Penggunaan:**

```dart
// Email input
YoTextFormField(
  labelText: 'Email',
  hintText: 'Enter your email',
  inputType: YoInputType.email,
  inputStyle: YoInputStyle.outlined,
  prefixIcon: Icon(Icons.email),
  isRequired: true,
)

// Password input
YoTextFormField(
  labelText: 'Password',
  inputType: YoInputType.password,
  showVisibilityToggle: true,
  validator: (value) {
    if (value == null || value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    return null;
  },
)

// Multiline input
YoTextFormField(
  labelText: 'Description',
  inputType: YoInputType.multiline,
  maxLines: 5,
  maxLength: 500,
  showCharacterCounter: true,
)

// Currency input with formatter
YoTextFormField(
  labelText: 'Price',
  inputType: YoInputType.currency,
  inputFormatters: [IndonesiaCurrencyFormatter()],
  prefixIcon: Text('Rp'),
)
```

---

### YoSearchField

Field pencarian dengan debounce dan suggestions.

**Parameters:**

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `hintText` | `String?` | `'Search...'` | Placeholder |
| `initialValue` | `String?` | `null` | Nilai awal |
| `onSearch` | `ValueChanged<String>?` | `null` | Callback debounced |
| `suggestions` | `List<String>?` | `null` | List suggestions |
| `debounceMs` | `int` | `300` | Delay debounce (ms) |
| `showClearButton` | `bool` | `true` | Tampilkan tombol clear |
| `autofocus` | `bool` | `false` | Auto-focus |
| `prefixIcon` | `Widget?` | `null` | Custom prefix icon |
| `borderRadius` | `double` | `12.0` | Border radius |
| `fillColor` | `Color?` | `null` | Warna fill |

**Contoh Penggunaan:**

```dart
YoSearchField(
  hintText: 'Search products...',
  suggestions: ['iPhone', 'Samsung', 'Xiaomi', 'Oppo'],
  debounceMs: 500,
  onSearch: (query) {
    searchProducts(query);
  },
)
```

---

### YoDropDown<T>

Dropdown dengan label dan validasi.

**Constructors:**
- `YoDropDown()` - Default outlined
- `YoDropDown.outlined()` - Same as default
- `YoDropDown.filled()` - Filled variant

**Parameters:**

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `value` | `T?` | required | Nilai terpilih |
| `onChanged` | `ValueChanged<T?>?` | required | Callback perubahan |
| `items` | `List<YoDropDownItem<T>>` | required | List items |
| `labelText` | `String?` | `null` | Label dropdown |
| `hintText` | `String?` | `null` | Hint saat kosong |
| `errorText` | `String?` | `null` | Pesan error |
| `helperText` | `String?` | `null` | Teks helper |
| `prefixIcon` | `Widget?` | `null` | Icon prefix |
| `enabled` | `bool` | `true` | Status enabled |
| `isRequired` | `bool` | `false` | Tandai required |
| `borderRadius` | `double` | `8.0` | Border radius |
| `isDense` | `bool` | `false` | Mode dense |

**YoDropDownItem Model:**

| Property | Type | Description |
|----------|------|-------------|
| `value` | `T` | Nilai item |
| `label` | `String` | Label display |
| `leading` | `Widget?` | Widget di depan |
| `trailing` | `Widget?` | Widget di belakang |
| `enabled` | `bool` | Status enabled (default: true) |

**Contoh Penggunaan:**

```dart
YoDropDown<String>(
  labelText: 'Category',
  hintText: 'Select a category',
  value: selectedCategory,
  isRequired: true,
  items: [
    YoDropDownItem(value: 'electronics', label: 'Electronics', leading: Icon(Icons.devices)),
    YoDropDownItem(value: 'clothing', label: 'Clothing', leading: Icon(Icons.checkroom)),
    YoDropDownItem(value: 'food', label: 'Food & Beverage', leading: Icon(Icons.restaurant)),
  ],
  onChanged: (value) => setState(() => selectedCategory = value),
)
```

---

### YoOtpField

Input kode OTP dengan auto-focus antar digit.

**Parameters:**

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `length` | `int` | `6` | Jumlah digit (1-10) |
| `onCompleted` | `ValueChanged<String>?` | `null` | Callback saat lengkap |
| `onChanged` | `ValueChanged<String>?` | `null` | Callback perubahan |
| `obscureText` | `bool` | `false` | Sembunyikan teks |
| `autofocus` | `bool` | `true` | Auto-focus field pertama |
| `fieldWidth` | `double` | `45` | Lebar tiap field |
| `fieldHeight` | `double` | `55` | Tinggi tiap field |
| `spacing` | `double` | `8` | Jarak antar field |
| `keyboardType` | `TextInputType` | `number` | Tipe keyboard |
| `fillColor` | `Color?` | `null` | Warna fill |
| `borderColor` | `Color?` | `null` | Warna border |
| `focusedBorderColor` | `Color?` | `null` | Warna border fokus |
| `textStyle` | `TextStyle?` | `null` | Style teks |
| `enabled` | `bool` | `true` | Status enabled |

**Contoh Penggunaan:**

```dart
YoOtpField(
  length: 6,
  onCompleted: (otp) {
    verifyOtp(otp);
  },
  onChanged: (value) {
    print('Current OTP: $value');
  },
)
```

---

### YoChipInput

Input untuk membuat tags/chips.

**Parameters:**

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `chips` | `List<String>` | `[]` | List chips awal |
| `onChanged` | `ValueChanged<List<String>>?` | `null` | Callback perubahan |
| `suggestions` | `List<String>?` | `null` | Autocomplete suggestions |
| `hintText` | `String?` | `'Add tag...'` | Hint text |
| `maxChips` | `int?` | `null` | Maksimal chips |
| `chipColor` | `Color?` | `null` | Warna chip |
| `chipTextColor` | `Color?` | `null` | Warna teks chip |
| `enabled` | `bool` | `true` | Status enabled |

**Contoh Penggunaan:**

```dart
YoChipInput(
  chips: ['Flutter', 'Dart'],
  suggestions: ['React', 'Vue', 'Angular', 'Swift', 'Kotlin'],
  maxChips: 5,
  onChanged: (chips) {
    setState(() => selectedTags = chips);
  },
)
```

---

### YoSlider

Slider untuk memilih nilai tunggal.

**Parameters:**

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `value` | `double` | required | Nilai saat ini |
| `onChanged` | `ValueChanged<double>` | required | Callback perubahan |
| `onChangeEnd` | `ValueChanged<double>?` | `null` | Callback selesai |
| `min` | `double` | `0.0` | Nilai minimum |
| `max` | `double` | `1.0` | Nilai maksimum |
| `divisions` | `int?` | `null` | Jumlah divisi diskrit |
| `label` | `String?` | `null` | Label tooltip |
| `activeColor` | `Color?` | `null` | Warna aktif |
| `inactiveColor` | `Color?` | `null` | Warna inaktif |
| `enabled` | `bool` | `true` | Status enabled |

**Contoh Penggunaan:**

```dart
YoSlider(
  value: volume,
  min: 0,
  max: 100,
  divisions: 10,
  label: '${volume.round()}%',
  onChanged: (value) => setState(() => volume = value),
)

// Slider with value display
YoSliderWithValue(
  value: price,
  min: 0,
  max: 1000000,
  divisions: 100,
  prefix: 'Rp ',
  suffix: '',
  onChanged: (value) => setState(() => price = value),
)
```

---

### YoRangeSlider

Slider untuk memilih rentang nilai.

**Parameters:**

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `values` | `RangeValues` | required | Rentang nilai |
| `min` | `double` | `0.0` | Minimum |
| `max` | `double` | `100.0` | Maximum |
| `divisions` | `int?` | `null` | Divisi |
| `onChanged` | `ValueChanged<RangeValues>?` | `null` | Callback perubahan |
| `onChangeEnd` | `ValueChanged<RangeValues>?` | `null` | Callback selesai |
| `labels` | `RangeLabels?` | `null` | Label kustom |
| `activeColor` | `Color?` | `null` | Warna aktif |
| `inactiveColor` | `Color?` | `null` | Warna inaktif |
| `showLabels` | `bool` | `true` | Tampilkan label |

**Contoh Penggunaan:**

```dart
YoRangeSlider(
  values: RangeValues(minPrice, maxPrice),
  min: 0,
  max: 10000000,
  divisions: 100,
  showLabels: true,
  onChanged: (range) {
    setState(() {
      minPrice = range.start;
      maxPrice = range.end;
    });
  },
)
```

---

### YoCheckbox

Checkbox dengan label opsional.

**Parameters:**

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `value` | `bool` | required | Status checked |
| `onChanged` | `ValueChanged<bool?>` | required | Callback perubahan |
| `label` | `String?` | `null` | Label teks |
| `activeColor` | `Color?` | `null` | Warna aktif |
| `checkColor` | `Color?` | `null` | Warna checkmark |
| `tristate` | `bool` | `false` | Mode tristate |
| `enabled` | `bool` | `true` | Status enabled |

**Contoh Penggunaan:**

```dart
YoCheckbox(
  value: agreeTerms,
  label: 'I agree to the Terms and Conditions',
  onChanged: (value) => setState(() => agreeTerms = value ?? false),
)

// Checkbox list tile
YoCheckboxListTile(
  value: receiveNewsletter,
  title: 'Subscribe to Newsletter',
  subtitle: 'Get weekly updates and promotions',
  onChanged: (value) => setState(() => receiveNewsletter = value ?? false),
)
```

---

### YoRadio<T>

Radio button dengan label opsional.

**Parameters:**

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `value` | `T` | required | Nilai radio ini |
| `groupValue` | `T?` | required | Nilai terpilih dalam grup |
| `onChanged` | `ValueChanged<T?>` | required | Callback perubahan |
| `label` | `String?` | `null` | Label teks |
| `activeColor` | `Color?` | `null` | Warna aktif |
| `toggleable` | `bool` | `false` | Dapat di-deselect |
| `enabled` | `bool` | `true` | Status enabled |

**Contoh Penggunaan:**

```dart
Column(
  children: [
    YoRadio<String>(
      value: 'male',
      groupValue: gender,
      label: 'Male',
      onChanged: (value) => setState(() => gender = value),
    ),
    YoRadio<String>(
      value: 'female',
      groupValue: gender,
      label: 'Female',
      onChanged: (value) => setState(() => gender = value),
    ),
  ],
)
```

---

### YoSwitch

Toggle switch dengan label opsional.

**Parameters:**

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `value` | `bool` | required | Status toggle |
| `onChanged` | `ValueChanged<bool>` | required | Callback perubahan |
| `label` | `String?` | `null` | Label teks |
| `activeColor` | `Color?` | `null` | Warna aktif |
| `inactiveColor` | `Color?` | `null` | Warna inaktif |
| `enabled` | `bool` | `true` | Status enabled |

**Contoh Penggunaan:**

```dart
YoSwitch(
  value: isDarkMode,
  label: 'Dark Mode',
  onChanged: (value) => toggleTheme(value),
)

// Switch list tile
YoSwitchListTile(
  value: notifications,
  title: 'Push Notifications',
  subtitle: 'Receive push notifications',
  onChanged: (value) => toggleNotifications(value),
)
```

---

### YoForm

Wrapper form dengan validasi.

**Parameters:**

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `formKey` | `GlobalKey<FormState>?` | `null` | Key form untuk akses eksternal |
| `children` | `List<Widget>` | required | Widget form children |
| `onSubmit` | `Function(Map<String, dynamic>)?` | `null` | Callback submit |
| `autoValidate` | `bool` | `false` | Validasi otomatis |
| `padding` | `EdgeInsetsGeometry?` | `null` | Padding form |
| `crossAxisAlignment` | `CrossAxisAlignment` | `start` | Cross axis alignment |
| `mainAxisAlignment` | `MainAxisAlignment` | `start` | Main axis alignment |

**YoFormController:**

```dart
class YoFormController {
  void reset();      // Reset form
  void save();       // Simpan form
  bool submit();     // Submit & validate, return true jika valid
  bool validate();   // Validasi saja
}
```

**Contoh Penggunaan:**

```dart
final formController = YoFormController();

YoForm(
  formKey: formController.formKey,
  children: [
    YoTextFormField(labelText: 'Name', isRequired: true),
    YoTextFormField(labelText: 'Email', inputType: YoInputType.email),
    YoTextFormField(labelText: 'Password', inputType: YoInputType.password),
    SizedBox(height: 16),
    YoButton(
      text: 'Submit',
      onPressed: () {
        if (formController.submit()) {
          // Form valid, proses data
        }
      },
    ),
  ],
)
```

---

## Feedback Components

Komponen untuk memberikan feedback kepada pengguna.

### YoToast

Notifikasi toast dari atas layar.

**Static Methods:**
- `YoToast.success()` - Toast sukses (hijau)
- `YoToast.error()` - Toast error (merah)
- `YoToast.warning()` - Toast warning (oranye)
- `YoToast.info()` - Toast info (biru)

**Parameters (semua methods):**

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `context` | `BuildContext` | required | Build context |
| `message` | `String` | required | Pesan toast |
| `duration` | `Duration` | `3s` | Durasi tampil |
| `onTap` | `VoidCallback?` | `null` | Callback tap |

**Contoh Penggunaan:**

```dart
// Success toast
YoToast.success(context, 'Data saved successfully!');

// Error toast with custom duration
YoToast.error(
  context, 
  'Failed to save data',
  duration: Duration(seconds: 5),
);

// Warning toast with action
YoToast.warning(
  context,
  'Your session will expire soon',
  onTap: () => extendSession(),
);
```

---

### YoSnackBar

Snackbar dengan berbagai tipe.

**Static Methods:**
- `YoSnackBar.show()` - Snackbar dengan konfigurasi lengkap
- `YoSnackBar.success()` - Snackbar sukses
- `YoSnackBar.error()` - Snackbar error
- `YoSnackBar.warning()` - Snackbar warning
- `YoSnackBar.info()` - Snackbar info
- `YoSnackBar.hide()` - Sembunyikan snackbar

**Parameters (show):**

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `context` | `BuildContext` | required | Build context |
| `message` | `String` | required | Pesan snackbar |
| `actionText` | `String?` | `null` | Teks action button |
| `onAction` | `VoidCallback?` | `null` | Callback action |
| `type` | `YoSnackBarType` | `info` | Tipe snackbar |
| `duration` | `Duration` | `4s` | Durasi tampil |
| `showIcon` | `bool` | `true` | Tampilkan icon |
| `floating` | `bool` | `true` | Style floating |

**Contoh Penggunaan:**

```dart
// Simple snackbar
YoSnackBar.success(context, 'Profile updated');

// Snackbar with action
YoSnackBar.show(
  context,
  message: 'Item deleted',
  actionText: 'Undo',
  onAction: () => undoDelete(),
  type: YoSnackBarType.warning,
);
```

---

### YoDialog

Dialog popup interaktif.

**Static Methods:**
- `YoDialog.show<T>()` - Dialog dengan return value
- `YoDialog.info()` - Dialog informasi
- `YoDialog.success()` - Dialog sukses
- `YoDialog.error()` - Dialog error
- `YoDialog.warning()` - Dialog warning

**Parameters (show):**

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `context` | `BuildContext` | required | Build context |
| `title` | `String` | required | Judul dialog |
| `message` | `String?` | `null` | Pesan dialog |
| `content` | `Widget?` | `null` | Konten kustom |
| `actions` | `List<Widget>?` | `null` | Action buttons |
| `icon` | `Widget?` | `null` | Icon widget |
| `showCloseButton` | `bool` | `false` | Tampilkan tombol close |
| `centerTitle` | `bool` | `true` | Center judul |
| `barrierDismissible` | `bool` | `true` | Tutup dengan tap di luar |
| `maxWidth` | `double?` | `400` | Lebar maksimal |

**Contoh Penggunaan:**

```dart
// Info dialog
YoDialog.info(
  context,
  title: 'Information',
  message: 'Your order has been placed successfully.',
);

// Custom dialog with actions
YoDialog.show<bool>(
  context,
  title: 'Update Available',
  message: 'A new version is available. Would you like to update now?',
  actions: [
    TextButton(
      onPressed: () => Navigator.pop(context, false),
      child: Text('Later'),
    ),
    ElevatedButton(
      onPressed: () => Navigator.pop(context, true),
      child: Text('Update'),
    ),
  ],
);
```

---

### YoConfirmDialog

Dialog konfirmasi dengan preset.

**Static Methods:**
- `YoConfirmDialog.show()` - Dialog konfirmasi
- `YoConfirmDialog.showDestructive()` - Konfirmasi aksi destruktif
- `YoConfirmDialog.showWithIcon()` - Konfirmasi dengan icon kustom

**Parameters (show):**

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `context` | `BuildContext` | required | Build context |
| `title` | `String` | required | Judul |
| `message` | `String` | required | Pesan |
| `confirmText` | `String` | `'Ya'` | Teks tombol konfirmasi |
| `cancelText` | `String` | `'Batal'` | Teks tombol batal |
| `isDestructive` | `bool` | `false` | Style destruktif |
| `icon` | `Widget?` | `null` | Icon |
| `showCancelButton` | `bool` | `true` | Tampilkan tombol batal |
| `barrierDismissible` | `bool` | `true` | Tutup dengan tap di luar |

**Contoh Penggunaan:**

```dart
// Simple confirmation
final confirmed = await YoConfirmDialog.show(
  context,
  title: 'Logout',
  message: 'Are you sure you want to logout?',
);
if (confirmed == true) logout();

// Destructive confirmation
final delete = await YoConfirmDialog.showDestructive(
  context,
  title: 'Delete Account',
  message: 'This action cannot be undone. All your data will be permanently deleted.',
);
if (delete == true) deleteAccount();
```

---

### YoBottomSheet

Bottom sheet dengan header dan actions.

**Static Methods:**
- `YoBottomSheet.show<T>()` - Bottom sheet dengan konten kustom
- `YoBottomSheet.showList<T>()` - Bottom sheet dengan list items

**Parameters (show):**

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `context` | `BuildContext` | required | Build context |
| `child` | `Widget` | required | Konten |
| `title` | `String?` | `null` | Judul |
| `actions` | `List<Widget>?` | `null` | Action widgets |
| `maxHeight` | `double?` | `null` | Tinggi maksimal |
| `contentPadding` | `EdgeInsetsGeometry?` | `null` | Padding konten |
| `isScrollControlled` | `bool` | `true` | Scroll controlled |
| `isDismissible` | `bool` | `true` | Dapat ditutup |
| `enableDrag` | `bool` | `true` | Enable drag |
| `showDragHandle` | `bool` | `true` | Tampilkan drag handle |
| `showDivider` | `bool` | `false` | Tampilkan divider |

**Parameters (showList):**

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `context` | `BuildContext` | required | Build context |
| `items` | `List<YoBottomSheetItem<T>>` | required | List items |
| `title` | `String?` | `null` | Judul |

**YoBottomSheetItem Model:**

| Property | Type | Description |
|----------|------|-------------|
| `title` | `String` | Judul item |
| `value` | `T` | Nilai item |
| `subtitle` | `String?` | Subtitle |
| `icon` | `IconData?` | Icon |
| `iconColor` | `Color?` | Warna icon |
| `trailing` | `Widget?` | Widget trailing |
| `onTap` | `VoidCallback?` | Callback tap |
| `enabled` | `bool` | Status enabled |

**Contoh Penggunaan:**

```dart
// Bottom sheet dengan list
final result = await YoBottomSheet.showList<String>(
  context,
  title: 'Select Action',
  items: [
    YoBottomSheetItem(value: 'edit', title: 'Edit', icon: Icons.edit),
    YoBottomSheetItem(value: 'share', title: 'Share', icon: Icons.share),
    YoBottomSheetItem(value: 'delete', title: 'Delete', icon: Icons.delete, iconColor: Colors.red),
  ],
);

// Bottom sheet dengan konten kustom
YoBottomSheet.show(
  context,
  title: 'Filter Products',
  child: Column(
    children: [
      // Filter widgets
    ],
  ),
  actions: [
    TextButton(onPressed: () => Navigator.pop(context), child: Text('Reset')),
    ElevatedButton(onPressed: () => applyFilter(), child: Text('Apply')),
  ],
);
```

---

### YoModal

Modal full-screen.

**Static Methods:**
- `YoModal.show<T>()` - Tampilkan modal

**Parameters:**

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `context` | `BuildContext` | required | Build context |
| `child` | `Widget` | required | Konten modal |
| `title` | `String?` | `null` | Judul |
| `height` | `double?` | `null` | Tinggi (fraksi jika <=1) |
| `isDismissible` | `bool` | `true` | Dapat ditutup |
| `showDragHandle` | `bool` | `true` | Tampilkan drag handle |
| `backgroundColor` | `Color?` | `null` | Warna background |
| `onDismiss` | `VoidCallback?` | `null` | Callback dismiss |

**Contoh Penggunaan:**

```dart
YoModal.show(
  context,
  title: 'Edit Profile',
  height: 0.9, // 90% tinggi layar
  child: ProfileEditForm(),
);
```

---

### YoDialogPicker

Dialog picker untuk tanggal dan waktu.

**Static Methods:**
- `YoDialogPicker.date()` - Picker tanggal
- `YoDialogPicker.dateRange()` - Picker rentang tanggal
- `YoDialogPicker.dateTime()` - Picker tanggal dan waktu
- `YoDialogPicker.time()` - Picker waktu
- `YoDialogPicker.month()` - Picker bulan
- `YoDialogPicker.year()` - Picker tahun

**Contoh Penggunaan:**

```dart
// Date picker
final date = await YoDialogPicker.date(
  context,
  initialDate: DateTime.now(),
  firstDate: DateTime(2020),
  lastDate: DateTime(2030),
);

// Date range picker
final range = await YoDialogPicker.dateRange(
  context,
  initialDateRange: DateTimeRange(
    start: DateTime.now(),
    end: DateTime.now().add(Duration(days: 7)),
  ),
);

// Time picker
final time = await YoDialogPicker.time(
  context,
  initialTime: TimeOfDay.now(),
);

// Year picker
final year = await YoDialogPicker.year(
  context,
  initialYear: 2026,
  firstYear: 2000,
  lastYear: 2050,
);
```

---

### YoLoading

Indikator loading dengan berbagai animasi.

**Constructors:**
- `YoLoading()` - Default
- `YoLoading.spinner()` - Circular spinner
- `YoLoading.dots()` - Bouncing dots
- `YoLoading.pulse()` - Pulsing circle
- `YoLoading.fade()` - Fading circles

**Parameters:**

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `size` | `double` | `24` | Ukuran |
| `color` | `Color?` | `null` | Warna |
| `strokeWidth` | `double` | `2.5` | Lebar stroke (spinner) |
| `type` | `YoLoadingType` | `spinner` | Tipe animasi |

**Enums:**

```dart
enum YoLoadingType { spinner, dots, pulse, fade }
```

**Contoh Penggunaan:**

```dart
Center(
  child: YoLoading.dots(
    size: 32,
    color: context.primaryColor,
  ),
)
```

---

### YoLoadingOverlay

Overlay loading di atas konten.

**Constructors:**
- `YoLoadingOverlay()` - Widget overlay
- `YoLoadingOverlay.show()` - Static method fullscreen
- `YoLoadingOverlay.hide()` - Sembunyikan
- `YoLoadingOverlay.showWhile<T>()` - Loading selama task

**Parameters (widget):**

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `isLoading` | `bool` | required | Status loading |
| `child` | `Widget` | required | Widget child |
| `message` | `String?` | `null` | Pesan loading |
| `overlayColor` | `Color?` | `null` | Warna overlay |
| `loadingType` | `YoLoadingType` | `spinner` | Tipe loading |
| `showBackground` | `bool` | `true` | Tampilkan background card |

**Contoh Penggunaan:**

```dart
// Widget overlay
YoLoadingOverlay(
  isLoading: isSubmitting,
  message: 'Saving...',
  child: Form(...),
)

// Static method
YoLoadingOverlay.show(context, message: 'Loading...');
// Do something
YoLoadingOverlay.hide(context);

// Show while executing task
final result = await YoLoadingOverlay.showWhile(
  context,
  task: () => fetchData(),
  message: 'Fetching data...',
);
```

---

### YoProgress

Indikator progress linear dan circular.

**Constructors:**
- `YoProgress()` - Default
- `YoProgress.linear()` - Linear progress
- `YoProgress.circular()` - Circular progress
- `YoProgress.circularWithValue()` - Circular dengan persentase

**Parameters:**

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `value` | `double?` | `null` | Nilai (0.0-1.0), null = indeterminate |
| `type` | `YoProgressType` | `circular` | Tipe progress |
| `size` | `YoProgressSize` | `medium` | Ukuran |
| `color` | `Color?` | `null` | Warna progress |
| `backgroundColor` | `Color?` | `null` | Warna track |
| `strokeWidth` | `double` | `4.0` | Lebar stroke |
| `label` | `String?` | `null` | Teks label |

**Enums:**

```dart
enum YoProgressType { linear, circular, circularWithValue }
enum YoProgressSize { small, medium, large }
```

**Contoh Penggunaan:**

```dart
// Linear determinate
YoProgress.linear(
  value: downloadProgress,
  color: context.successColor,
)

// Circular with percentage
YoProgress.circularWithValue(
  value: 0.75,
  size: YoProgressSize.large,
  label: 'Uploading',
)

// Indeterminate
YoProgress.circular() // No value = indeterminate
```

---

### YoSkeleton

Placeholder loading skeleton.

**Constructors:**
- `YoSkeleton()` - Default
- `YoSkeleton.circle()` - Skeleton lingkaran
- `YoSkeleton.line()` - Skeleton garis
- `YoSkeleton.rounded()` - Skeleton rounded
- `YoSkeleton.square()` - Skeleton kotak
- `YoSkeleton.paragraph()` - Skeleton paragraf (multi-line)

**Parameters:**

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `width` | `double?` | `null` | Lebar |
| `height` | `double?` | `20` | Tinggi |
| `borderRadius` | `BorderRadius` | `4` | Border radius |
| `type` | `YoSkeletonType` | `shimmer` | Tipe animasi |
| `baseColor` | `Color?` | `null` | Warna dasar |
| `highlightColor` | `Color?` | `null` | Warna highlight |
| `enabled` | `bool` | `true` | Status enabled |

**Enums:**

```dart
enum YoSkeletonType { static, shimmer }
```

**Contoh Penggunaan:**

```dart
// Loading card
Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    YoSkeleton(height: 200), // Image placeholder
    SizedBox(height: 12),
    YoSkeleton.line(width: 200), // Title
    SizedBox(height: 8),
    YoSkeleton.paragraph(lines: 2), // Description
  ],
)

// Loading avatar with text
Row(
  children: [
    YoSkeleton.circle(size: 48),
    SizedBox(width: 12),
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        YoSkeleton.line(width: 120, height: 14),
        SizedBox(height: 4),
        YoSkeleton.line(width: 80, height: 12),
      ],
    ),
  ],
)
```

---

### YoShimmer

Efek shimmer untuk loading.

**Constructors:**
- `YoShimmer()` - Wrapper shimmer
- `YoShimmer.card()` - Shimmer untuk card
- `YoShimmer.image()` - Shimmer untuk image
- `YoShimmer.listTile()` - Shimmer untuk list tile

**Parameters:**

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `child` | `Widget` | required | Widget child |
| `baseColor` | `Color?` | `null` | Warna dasar |
| `highlightColor` | `Color?` | `null` | Warna highlight |
| `duration` | `Duration` | `1500ms` | Durasi animasi |
| `direction` | `ShimmerDirection` | `leftToRight` | Arah shimmer |
| `enabled` | `bool` | `true` | Status enabled |

**Enums:**

```dart
enum ShimmerDirection { leftToRight, rightToLeft, topToBottom, bottomToTop }
```

**Contoh Penggunaan:**

```dart
// Shimmer wrapper
YoShimmer(
  child: Container(
    width: 200,
    height: 100,
    color: Colors.grey[300],
  ),
)

// Preset shimmer
YoShimmer.card(height: 150)
YoShimmer.listTile()
```

---

### YoSkeletonCard / YoSkeletonListTile / YoSkeletonGrid

Skeleton preset untuk komponen umum.

**Contoh Penggunaan:**

```dart
// Skeleton card
YoSkeletonCard(
  hasImage: true,
  hasTitle: true,
  hasDescription: true,
  descriptionLines: 2,
)

// Skeleton list tile
YoSkeletonListTile.withLeading(
  hasSubtitle: true,
  hasTrailing: true,
)

// Skeleton grid
YoSkeletonGrid(
  itemCount: 6,
  crossAxisCount: 2,
  childAspectRatio: 0.8,
)
```

---

### YoEmptyState

Tampilan saat data kosong atau error.

**Constructors:**
- `YoEmptyState()` - Default
- `YoEmptyState.noData()` - Tidak ada data
- `YoEmptyState.noConnection()` - Tidak ada koneksi
- `YoEmptyState.error()` - Terjadi error
- `YoEmptyState.searchNotFound()` - Pencarian tidak ditemukan
- `YoEmptyState.custom()` - Dengan gambar kustom

**Parameters:**

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `title` | `String` | required | Judul |
| `description` | `String` | required | Deskripsi |
| `icon` | `Widget?` | `null` | Icon |
| `actionText` | `String?` | `null` | Teks tombol aksi |
| `onAction` | `VoidCallback?` | `null` | Callback aksi |
| `secondaryActionText` | `String?` | `null` | Teks aksi sekunder |
| `onSecondaryAction` | `VoidCallback?` | `null` | Callback aksi sekunder |
| `type` | `YoEmptyStateType` | `general` | Tipe empty state |
| `error` | `Object?` | `null` | Objek error |
| `showErrorDetails` | `bool` | `false` | Tampilkan detail error |

**Contoh Penggunaan:**

```dart
// No data state
YoEmptyState.noData(
  title: 'No Products Found',
  description: 'Try changing your filters or search keywords',
  actionText: 'Clear Filters',
  onAction: () => clearFilters(),
)

// No connection state
YoEmptyState.noConnection(
  onAction: () => retryConnection(),
)

// Error state with details
YoEmptyState.error(
  error: exception,
  showErrorDetails: true,
  onAction: () => retry(),
)
```

---

### YoErrorState

Widget error state sederhana.

**Parameters:**

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `title` | `String` | `'Terjadi Kesalahan'` | Judul |
| `description` | `String` | Default message | Deskripsi |
| `actionText` | `String` | `'Coba Lagi'` | Teks tombol |
| `onRetry` | `VoidCallback` | required | Callback retry |
| `error` | `Object?` | `null` | Objek error |

**Contoh Penggunaan:**

```dart
YoErrorState(
  title: 'Failed to Load',
  description: 'Unable to fetch data from server',
  onRetry: () => fetchData(),
)
```

---

### YoBanner

Banner informasi di atas layar.

**Parameters:**

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `message` | `String` | required | Pesan banner |
| `type` | `YoBannerType` | `info` | Tipe banner |
| `action` | `Widget?` | `null` | Widget action |
| `dismissible` | `bool` | `true` | Dapat di-dismiss |
| `onDismiss` | `VoidCallback?` | `null` | Callback dismiss |
| `padding` | `EdgeInsetsGeometry?` | `null` | Padding |

**Enums:**

```dart
enum YoBannerType { info, warning, error, success }
```

**Contoh Penggunaan:**

```dart
YoBanner(
  message: 'Your subscription will expire in 3 days',
  type: YoBannerType.warning,
  action: TextButton(
    onPressed: () => renewSubscription(),
    child: Text('Renew Now'),
  ),
  onDismiss: () => dismissBanner(),
)
```

---

## Navigation Components

Komponen untuk navigasi dan layout halaman.

### YoAppBar

App bar dengan berbagai varian.

**Constructors:**
- `YoAppBar()` - Default
- `YoAppBar.elevated()` - Dengan shadow
- `YoAppBar.primary()` - Warna primary
- `YoAppBar.surface()` - Warna surface
- `YoAppBar.transparent()` - Transparan

**Parameters:**

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `title` | `String` | required | Judul |
| `leading` | `Widget?` | `null` | Widget leading |
| `actions` | `List<Widget>?` | `null` | Action widgets |
| `automaticallyImplyLeading` | `bool` | `true` | Auto back button |
| `variant` | `YoAppBarVariant` | `primary` | Varian style |
| `backgroundColor` | `Color?` | `null` | Override warna |
| `elevation` | `double` | `0` | Elevasi shadow |
| `onBackPressed` | `VoidCallback?` | `null` | Custom back handler |
| `titleStyle` | `TextStyle?` | `null` | Style judul |
| `centerTitle` | `bool` | `true` | Center judul |
| `toolbarHeight` | `double?` | `null` | Tinggi toolbar |

**Enums:**

```dart
enum YoAppBarVariant { primary, surface, transparent, elevated }
```

**Contoh Penggunaan:**

```dart
Scaffold(
  appBar: YoAppBar(
    title: 'Dashboard',
    actions: [
      IconButton(icon: Icon(Icons.search), onPressed: () {}),
      IconButton(icon: Icon(Icons.notifications), onPressed: () {}),
    ],
  ),
  body: ...,
)

// Transparent app bar for profile
YoAppBar.transparent(
  title: 'Profile',
  actions: [
    IconButton(icon: Icon(Icons.settings), onPressed: () {}),
  ],
)
```

---

### YoBottomNavBar

Bottom navigation bar dengan animasi.

**Parameters:**

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `currentIndex` | `int` | required | Index terpilih |
| `items` | `List<YoNavItem>` | required | Nav items (2-5) |
| `onTap` | `ValueChanged<int>` | required | Callback tap |
| `backgroundColor` | `Color?` | `null` | Warna background |
| `activeColor` | `Color?` | `null` | Warna aktif |
| `inactiveColor` | `Color?` | `null` | Warna inaktif |
| `height` | `double` | `64` | Tinggi bar |
| `showLabels` | `bool` | `true` | Tampilkan label |
| `animationDuration` | `Duration` | `200ms` | Durasi animasi |
| `animationCurve` | `Curve` | `easeInOut` | Curve animasi |

**YoNavItem Model:**

| Property | Type | Description |
|----------|------|-------------|
| `icon` | `IconData` | Icon |
| `label` | `String` | Label |
| `activeIcon` | `IconData?` | Icon saat aktif |
| `badge` | `String?` | Badge text |
| `badgeColor` | `Color?` | Warna badge |

**Contoh Penggunaan:**

```dart
YoBottomNavBar(
  currentIndex: _selectedIndex,
  onTap: (index) => setState(() => _selectedIndex = index),
  items: [
    YoNavItem(icon: Icons.home, label: 'Home'),
    YoNavItem(icon: Icons.search, label: 'Search'),
    YoNavItem(icon: Icons.shopping_cart, label: 'Cart', badge: '3'),
    YoNavItem(icon: Icons.person, label: 'Profile'),
  ],
)
```

---

### YoTabBar

Tab bar dengan badge support.

**Parameters:**

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `tabs` | `List<YoTabItem>` | required | Tab items |
| `currentIndex` | `int` | required | Index terpilih |
| `onTap` | `ValueChanged<int>` | required | Callback tap |
| `isScrollable` | `bool` | `false` | Scrollable tabs |
| `indicatorColor` | `Color?` | `null` | Warna indicator |
| `indicatorWeight` | `double` | `2.0` | Tebal indicator |
| `labelColor` | `Color?` | `null` | Warna label aktif |
| `unselectedLabelColor` | `Color?` | `null` | Warna label inaktif |
| `height` | `double?` | `48` | Tinggi tab bar |

**YoTabItem Model:**

| Property | Type | Description |
|----------|------|-------------|
| `text` | `String` | Label tab |
| `icon` | `IconData?` | Icon |
| `customWidget` | `Widget?` | Widget kustom |
| `badge` | `String?` | Badge text |
| `badgeColor` | `Color?` | Warna badge |

**Contoh Penggunaan:**

```dart
Column(
  children: [
    YoTabBar(
      currentIndex: _tabIndex,
      onTap: (index) => setState(() => _tabIndex = index),
      tabs: [
        YoTabItem(text: 'All'),
        YoTabItem(text: 'Active', badge: '5'),
        YoTabItem(text: 'Completed'),
      ],
    ),
    Expanded(
      child: IndexedStack(
        index: _tabIndex,
        children: [AllTab(), ActiveTab(), CompletedTab()],
      ),
    ),
  ],
)
```

---

### YoSidebar

Sidebar navigation dengan collapse support.

**Parameters:**

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `items` | `List<YoSidebarItem>` | required | Sidebar items |
| `selectedIndex` | `int?` | `null` | Index terpilih |
| `onItemTap` | `ValueChanged<int>?` | `null` | Callback tap |
| `isExpanded` | `bool` | `true` | Status expanded |
| `onExpandedChanged` | `ValueChanged<bool>?` | `null` | Callback expand |
| `expandedWidth` | `double` | `250` | Lebar expanded |
| `collapsedWidth` | `double` | `72` | Lebar collapsed |
| `backgroundColor` | `Color?` | `null` | Warna background |
| `activeColor` | `Color?` | `null` | Warna aktif |
| `inactiveColor` | `Color?` | `null` | Warna inaktif |
| `header` | `Widget?` | `null` | Header widget |
| `footer` | `Widget?` | `null` | Footer widget |
| `showToggleButton` | `bool` | `true` | Tampilkan toggle button |

**YoSidebarItem Model:**

| Property | Type | Description |
|----------|------|-------------|
| `icon` | `IconData` | Icon |
| `label` | `String` | Label |
| `activeIcon` | `IconData?` | Icon aktif |
| `badge` | `String?` | Badge |
| `badgeColor` | `Color?` | Warna badge |
| `onTap` | `VoidCallback?` | Callback tap |
| `children` | `List<YoSidebarItem>?` | Sub-menu items |

**Contoh Penggunaan:**

```dart
Row(
  children: [
    YoSidebar(
      selectedIndex: _selectedIndex,
      onItemTap: (index) => setState(() => _selectedIndex = index),
      header: Padding(
        padding: EdgeInsets.all(16),
        child: Text('Admin Panel'),
      ),
      items: [
        YoSidebarItem(icon: Icons.dashboard, label: 'Dashboard'),
        YoSidebarItem(icon: Icons.people, label: 'Users', badge: '12'),
        YoSidebarItem(
          icon: Icons.settings,
          label: 'Settings',
          children: [
            YoSidebarItem(icon: Icons.person, label: 'Profile'),
            YoSidebarItem(icon: Icons.security, label: 'Security'),
          ],
        ),
      ],
    ),
    Expanded(child: MainContent()),
  ],
)
```

---

### YoDrawer

Drawer dengan header dan footer.

**Parameters:**

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `header` | `Widget?` | `null` | Header (YoDrawerHeader) |
| `items` | `List<YoDrawerItem>` | required | Drawer items |
| `footer` | `Widget?` | `null` | Footer (YoDrawerFooter) |
| `width` | `double` | `280` | Lebar drawer |
| `backgroundColor` | `Color?` | `null` | Warna background |
| `elevation` | `double` | `16.0` | Elevasi |

**YoDrawerItem:**

| Property | Type | Description |
|----------|------|-------------|
| `icon` | `IconData?` | Icon |
| `title` | `String` | Judul |
| `subtitle` | `String?` | Subtitle |
| `trailing` | `Widget?` | Widget trailing |
| `onTap` | `VoidCallback?` | Callback tap |
| `isSelected` | `bool` | Status selected |
| `isDivider` | `bool` | Render sebagai divider |
| `isHeader` | `bool` | Render sebagai section header |

**Named Constructors:**
- `YoDrawerItem.divider()` - Divider line
- `YoDrawerItem.header(String title)` - Section header

**Contoh Penggunaan:**

```dart
Scaffold(
  drawer: YoDrawer(
    header: YoDrawerHeader(
      title: 'John Doe',
      subtitle: 'john@example.com',
      imageUrl: 'https://example.com/avatar.jpg',
    ),
    items: [
      YoDrawerItem(icon: Icons.home, title: 'Home', onTap: () => navigateTo('/')),
      YoDrawerItem(icon: Icons.person, title: 'Profile', onTap: () => navigateTo('/profile')),
      YoDrawerItem.divider(),
      YoDrawerItem.header('Settings'),
      YoDrawerItem(icon: Icons.settings, title: 'Preferences'),
      YoDrawerItem(icon: Icons.logout, title: 'Logout', onTap: () => logout()),
    ],
    footer: YoDrawerFooter(
      text: 'MyApp',
      version: '1.0.0',
    ),
  ),
  body: ...,
)
```

---

### YoStepper

Stepper untuk wizard/multi-step forms.

**Parameters:**

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `steps` | `List<YoStep>` | required | List steps |
| `currentStep` | `int` | `0` | Step aktif |
| `onStepTapped` | `ValueChanged<int>?` | `null` | Callback tap step |
| `onStepContinue` | `VoidCallback?` | `null` | Callback continue |
| `onStepCancel` | `VoidCallback?` | `null` | Callback cancel |
| `type` | `YoStepperType` | `vertical` | Tipe layout |
| `continueButton` | `Widget?` | `null` | Custom continue button |
| `cancelButton` | `Widget?` | `null` | Custom cancel button |
| `activeColor` | `Color?` | `null` | Warna aktif |
| `inactiveColor` | `Color?` | `null` | Warna inaktif |

**YoStep Model:**

| Property | Type | Description |
|----------|------|-------------|
| `title` | `String` | Judul step |
| `subtitle` | `String?` | Subtitle |
| `content` | `Widget` | Konten step |
| `state` | `YoStepState` | Status step |
| `isActive` | `bool` | Status aktif |

**Enums:**

```dart
enum YoStepperType { vertical, horizontal }
enum YoStepState { indexed, editing, complete, disabled, error }
```

**Contoh Penggunaan:**

```dart
YoStepper(
  currentStep: _currentStep,
  type: YoStepperType.horizontal,
  onStepTapped: (step) => setState(() => _currentStep = step),
  onStepContinue: () {
    if (_currentStep < 2) setState(() => _currentStep++);
    else submitForm();
  },
  onStepCancel: () {
    if (_currentStep > 0) setState(() => _currentStep--);
  },
  steps: [
    YoStep(
      title: 'Account',
      content: AccountForm(),
      state: _currentStep > 0 ? YoStepState.complete : YoStepState.indexed,
    ),
    YoStep(
      title: 'Personal',
      content: PersonalForm(),
      state: _currentStep > 1 ? YoStepState.complete : YoStepState.indexed,
    ),
    YoStep(
      title: 'Confirm',
      content: ConfirmationView(),
    ),
  ],
)
```

---

### YoBreadcrumb

Breadcrumb navigation trail.

**Parameters:**

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `items` | `List<YoBreadcrumbItem>` | required | Breadcrumb items |
| `separator` | `Widget?` | `null` | Custom separator |
| `maxItems` | `int?` | `null` | Max items (truncate dengan ellipsis) |
| `textStyle` | `TextStyle?` | `null` | Style item inaktif |
| `activeTextStyle` | `TextStyle?` | `null` | Style item aktif |
| `separatorColor` | `Color?` | `null` | Warna separator |

**YoBreadcrumbItem Model:**

| Property | Type | Description |
|----------|------|-------------|
| `label` | `String` | Label breadcrumb |
| `onTap` | `VoidCallback?` | Callback tap |
| `icon` | `IconData?` | Icon opsional |

**Contoh Penggunaan:**

```dart
YoBreadcrumb(
  items: [
    YoBreadcrumbItem(label: 'Home', icon: Icons.home, onTap: () => goHome()),
    YoBreadcrumbItem(label: 'Products', onTap: () => goToProducts()),
    YoBreadcrumbItem(label: 'Electronics', onTap: () => goToElectronics()),
    YoBreadcrumbItem(label: 'Smartphones'), // Last item, no onTap
  ],
)
```

---

### YoPagination

Widget pagination untuk navigasi halaman.

**Parameters:**

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `currentPage` | `int` | required | Halaman saat ini (1-based) |
| `totalPages` | `int` | required | Total halaman |
| `onPageChanged` | `ValueChanged<int>` | required | Callback perubahan |
| `maxButtons` | `int` | `5` | Max page buttons |
| `showFirstLast` | `bool` | `true` | Tampilkan first/last |
| `showPrevNext` | `bool` | `true` | Tampilkan prev/next |
| `activeColor` | `Color?` | `null` | Warna aktif |
| `inactiveColor` | `Color?` | `null` | Warna inaktif |
| `buttonSize` | `double` | `40` | Ukuran button |
| `padding` | `EdgeInsetsGeometry?` | `null` | Padding |

**Contoh Penggunaan:**

```dart
YoPagination(
  currentPage: currentPage,
  totalPages: 20,
  onPageChanged: (page) {
    setState(() => currentPage = page);
    loadPage(page);
  },
)
```

---

## Picker Components

Komponen untuk memilih nilai (tanggal, warna, file, dll).

### YoDatePicker

Picker tanggal.

**Parameters:**

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `selectedDate` | `DateTime?` | `null` | Tanggal terpilih |
| `onDateChanged` | `ValueChanged<DateTime>` | required | Callback perubahan |
| `firstDate` | `DateTime?` | `null` | Tanggal pertama |
| `lastDate` | `DateTime?` | `null` | Tanggal terakhir |
| `labelText` | `String?` | `null` | Label |
| `hintText` | `String?` | `null` | Hint |
| `icon` | `IconData?` | `null` | Icon |
| `enabled` | `bool` | `true` | Status enabled |
| `borderRadius` | `double` | `8.0` | Border radius |
| `borderColor` | `Color?` | `null` | Warna border |
| `backgroundColor` | `Color?` | `null` | Warna background |

**Contoh Penggunaan:**

```dart
YoDatePicker(
  labelText: 'Birth Date',
  selectedDate: birthDate,
  firstDate: DateTime(1950),
  lastDate: DateTime.now(),
  onDateChanged: (date) => setState(() => birthDate = date),
)
```

---

### YoTimePicker

Picker waktu.

**Parameters:**

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `selectedTime` | `TimeOfDay?` | `null` | Waktu terpilih |
| `onTimeChanged` | `ValueChanged<TimeOfDay>` | required | Callback perubahan |
| `labelText` | `String?` | `null` | Label |
| `hintText` | `String?` | `null` | Hint |
| `icon` | `IconData?` | `null` | Icon |
| `enabled` | `bool` | `true` | Status enabled |
| `borderRadius` | `double` | `8.0` | Border radius |

**Contoh Penggunaan:**

```dart
YoTimePicker(
  labelText: 'Meeting Time',
  selectedTime: meetingTime,
  onTimeChanged: (time) => setState(() => meetingTime = time),
)
```

---

### YoDateTimePicker

Picker tanggal dan waktu gabungan.

**Parameters:**

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `selectedDateTime` | `DateTime?` | `null` | DateTime terpilih |
| `onDateTimeChanged` | `ValueChanged<DateTime>` | required | Callback perubahan |
| `firstDate` | `DateTime?` | `null` | DateTime pertama |
| `lastDate` | `DateTime?` | `null` | DateTime terakhir |
| `labelText` | `String?` | `null` | Label |
| `hintText` | `String?` | `null` | Hint |
| `enabled` | `bool` | `true` | Status enabled |

**Contoh Penggunaan:**

```dart
YoDateTimePicker(
  labelText: 'Event Date & Time',
  selectedDateTime: eventDateTime,
  firstDate: DateTime.now(),
  lastDate: DateTime.now().add(Duration(days: 365)),
  onDateTimeChanged: (dt) => setState(() => eventDateTime = dt),
)
```

---

### YoDateRangePicker

Picker rentang tanggal.

**Constructors:**
- `YoDateRangePicker()` - Default
- `YoDateRangePicker.compact()` - Layout compact

**Parameters:**

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `selectedRange` | `DateTimeRange?` | `null` | Range terpilih |
| `onRangeChanged` | `ValueChanged<DateTimeRange>` | required | Callback perubahan |
| `firstDate` | `DateTime?` | `null` | Tanggal pertama |
| `lastDate` | `DateTime?` | `null` | Tanggal terakhir |
| `labelText` | `String?` | `null` | Label |
| `hintText` | `String?` | `null` | Hint |
| `startLabel` | `String` | `'Start'` | Label start |
| `endLabel` | `String` | `'End'` | Label end |
| `compactLayout` | `bool` | `false` | Layout compact |
| `enabled` | `bool` | `true` | Status enabled |

**Contoh Penggunaan:**

```dart
YoDateRangePicker(
  labelText: 'Trip Dates',
  selectedRange: tripDates,
  onRangeChanged: (range) => setState(() => tripDates = range),
)

// Compact layout
YoDateRangePicker.compact(
  startLabel: 'Check-in',
  endLabel: 'Check-out',
  selectedRange: bookingDates,
  onRangeChanged: (range) => setState(() => bookingDates = range),
)
```

---

### YoMonthPicker

Picker bulan.

**Parameters:**

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `selectedRange` | `DateTimeRange?` | `null` | Range bulan terpilih |
| `onMonthChanged` | `ValueChanged<DateTimeRange>` | required | Callback |
| `firstDate` | `DateTime?` | `null` | Tanggal pertama |
| `lastDate` | `DateTime?` | `null` | Tanggal terakhir |
| `labelText` | `String?` | `null` | Label |
| `hintText` | `String?` | `null` | Hint |
| `showYear` | `bool` | `true` | Tampilkan tahun |
| `enabled` | `bool` | `true` | Status enabled |

**Contoh Penggunaan:**

```dart
YoMonthPicker(
  labelText: 'Report Month',
  selectedRange: reportMonth,
  onMonthChanged: (range) => setState(() => reportMonth = range),
)
```

---

### YoYearPicker

Picker tahun.

**Parameters:**

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `selectedYear` | `int?` | `null` | Tahun terpilih |
| `onYearChanged` | `ValueChanged<int>` | required | Callback |
| `firstYear` | `int?` | `null` | Tahun pertama |
| `lastYear` | `int?` | `null` | Tahun terakhir |
| `labelText` | `String?` | `null` | Label |
| `hintText` | `String?` | `null` | Hint |
| `enabled` | `bool` | `true` | Status enabled |

**Contoh Penggunaan:**

```dart
YoYearPicker(
  labelText: 'Year of Graduation',
  selectedYear: graduationYear,
  firstYear: 1990,
  lastYear: DateTime.now().year,
  onYearChanged: (year) => setState(() => graduationYear = year),
)
```

---

### YoInlineDatePicker

Picker tanggal inline (wheel style).

**Parameters:**

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `selectedDate` | `DateTime?` | `null` | Tanggal terpilih |
| `onDateChanged` | `ValueChanged<DateTime>` | required | Callback |
| `firstDate` | `DateTime?` | `null` | Tanggal pertama |
| `lastDate` | `DateTime?` | `null` | Tanggal terakhir |
| `itemExtent` | `double` | `50.0` | Tinggi item |
| `diameterRatio` | `double` | `1.1` | Diameter ratio wheel |
| `magnification` | `double` | `1.2` | Magnifikasi item terpilih |

**Contoh Penggunaan:**

```dart
YoInlineDatePicker(
  selectedDate: selectedDate,
  onDateChanged: (date) => setState(() => selectedDate = date),
)
```

---

### YoColorPicker

Picker warna dengan palette dan hex input.

**Static Methods:**
- `YoColorPicker.showAsBottomSheet()` - Picker sebagai bottom sheet
- `YoColorPicker.showAsDialog()` - Picker sebagai dialog

**Parameters:**

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `selectedColor` | `Color?` | `null` | Warna terpilih |
| `onColorSelected` | `ValueChanged<Color>` | required | Callback |
| `initialPalette` | `YoColorPalette` | `material` | Palette awal |
| `showHexInput` | `bool` | `true` | Tampilkan hex input |
| `showRgbSliders` | `bool` | `true` | Tampilkan RGB sliders |
| `showOpacity` | `bool` | `false` | Tampilkan opacity slider |
| `showPalettes` | `bool` | `true` | Tampilkan palette tabs |
| `showPreview` | `bool` | `true` | Tampilkan preview |
| `crossAxisCount` | `int` | `6` | Kolom grid |
| `height` | `double` | `400` | Tinggi picker |

**Enums:**

```dart
enum YoColorPalette { material, pastel, grayscale, custom }
```

**Contoh Penggunaan:**

```dart
// As dialog
final color = await YoColorPicker.showAsDialog(
  context,
  selectedColor: currentColor,
  showOpacity: true,
);
if (color != null) setState(() => currentColor = color);

// Button with picker
YoColorPickerButton(
  selectedColor: themeColor,
  onColorSelected: (color) => setState(() => themeColor = color),
  labelText: 'Theme Color',
)
```

---

### YoIconPicker

Picker icon dengan kategori dan pencarian.

**Static Methods:**
- `YoIconPicker.showAsBottomSheet()` - Picker sebagai bottom sheet
- `YoIconPicker.showAsDialog()` - Picker sebagai dialog

**Parameters:**

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `selectedIcon` | `IconData?` | `null` | Icon terpilih |
| `onIconSelected` | `ValueChanged<IconData>` | required | Callback |
| `initialCategory` | `YoIconCategory` | `all` | Kategori awal |
| `iconSize` | `double` | `24` | Ukuran icon |
| `crossAxisCount` | `int` | `6` | Kolom grid |
| `showSearch` | `bool` | `true` | Tampilkan search |
| `showCategories` | `bool` | `true` | Tampilkan kategori tabs |
| `searchHint` | `String` | `'Search icons...'` | Hint pencarian |
| `height` | `double` | `300` | Tinggi picker |

**Contoh Penggunaan:**

```dart
// As bottom sheet
final icon = await YoIconPicker.showAsBottomSheet(
  context,
  selectedIcon: categoryIcon,
);
if (icon != null) setState(() => categoryIcon = icon);

// Button with picker
YoIconPickerButton(
  selectedIcon: menuIcon,
  onIconSelected: (icon) => setState(() => menuIcon = icon),
  labelText: 'Menu Icon',
)
```

---

### YoFilePicker

Utility class untuk memilih file.

**Static Methods:**
- `YoFilePicker.pickFile()` - Pilih satu file
- `YoFilePicker.pickAny()` - Pilih file apapun
- `YoFilePicker.pickImage()` - Pilih gambar
- `YoFilePicker.pickVideo()` - Pilih video
- `YoFilePicker.pickAudio()` - Pilih audio
- `YoFilePicker.pickDocument()` - Pilih dokumen
- `YoFilePicker.pickPdf()` - Pilih PDF
- `YoFilePicker.pickCustom()` - Pilih dengan ekstensi kustom
- `YoFilePicker.pickMultiple()` - Pilih banyak file
- `YoFilePicker.pickDirectory()` - Pilih direktori

**Enums:**

```dart
enum YoFileType { any, media, image, video, audio, custom }
```

**Related Widgets:**
- `YoFilePickerButton` - Button untuk memilih file
- `YoFileDropZone` - Drag & drop zone
- `YoFileListTile` - List tile untuk file terpilih

**Contoh Penggunaan:**

```dart
// Pick single file
final result = await YoFilePicker.pickImage();
if (result != null) {
  print('File: ${result.name}, Size: ${result.formattedSize}');
}

// File picker button
YoFilePickerButton(
  selectedFile: selectedFile,
  fileType: YoFileType.document,
  onFileSelected: (file) => setState(() => selectedFile = file),
)

// Drop zone
YoFileDropZone(
  multiple: true,
  onFilesSelected: (files) => setState(() => uploadFiles = files),
)
```

---

### YoImagePicker

Utility class untuk memilih gambar.

**Static Methods:**
- `YoImagePicker.pick()` - Pilih gambar dari sumber tertentu
- `YoImagePicker.pickFromCamera()` - Dari kamera
- `YoImagePicker.pickFromGallery()` - Dari galeri
- `YoImagePicker.pickMultiple()` - Pilih banyak gambar
- `YoImagePicker.pickVideoFromCamera()` - Video dari kamera
- `YoImagePicker.pickVideoFromGallery()` - Video dari galeri
- `YoImagePicker.showSourcePicker()` - Bottom sheet pilih sumber

**YoImagePickerConfig Presets:**
- `YoImagePickerConfig.defaultConfig` - Default
- `YoImagePickerConfig.compressed` - Terkompresi (1024x1024, quality: 80)
- `YoImagePickerConfig.highQuality` - Kualitas tinggi (quality: 100)
- `YoImagePickerConfig.thumbnail` - Thumbnail (256x256, quality: 70)
- `YoImagePickerConfig.avatar` - Avatar (512x512, quality: 85)

**Related Widgets:**
- `YoImagePickerButton` - Button untuk memilih gambar
- `YoAvatarPicker` - Picker avatar circular

**Contoh Penggunaan:**

```dart
// Show source picker
final result = await YoImagePicker.showSourcePicker(
  context,
  config: YoImagePickerConfig.compressed,
);
if (result != null) {
  setState(() => imagePath = result.path);
}

// Image picker button
YoImagePickerButton(
  imagePath: selectedImagePath,
  onImageSelected: (result) => setState(() => selectedImagePath = result.path),
  multiple: false,
)

// Avatar picker
YoAvatarPicker(
  imageUrl: currentAvatarUrl,
  onImageSelected: (result) => uploadAvatar(result),
  size: 120,
)
```

---

## Layout Components

Komponen untuk mengatur layout.

### YoGrid

Grid layout dengan responsive support.

**Constructors:**
- `YoGrid()` - Default
- `YoGrid.responsive()` - Responsive dengan breakpoints
- `YoGrid.twoColumn()` - 2 kolom
- `YoGrid.threeColumn()` - 3 kolom

**Parameters:**

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `crossAxisCount` | `int` | required | Jumlah kolom |
| `crossAxisSpacing` | `double` | `0` | Jarak horizontal |
| `mainAxisSpacing` | `double` | `0` | Jarak vertikal |
| `childAspectRatio` | `double` | `1.0` | Aspect ratio child |
| `children` | `List<Widget>` | required | Widget children |
| `padding` | `EdgeInsets` | `zero` | Padding |
| `shrinkWrap` | `bool` | `false` | Shrink wrap |
| `physics` | `ScrollPhysics?` | `null` | Scroll physics |

**Parameters (responsive):**

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `phoneColumns` | `int?` | `2` | Kolom di phone |
| `tabletColumns` | `int?` | `3` | Kolom di tablet |
| `desktopColumns` | `int?` | `4` | Kolom di desktop |

**Contoh Penggunaan:**

```dart
// Responsive grid
YoGrid.responsive(
  context: context,
  phoneColumns: 2,
  tabletColumns: 3,
  desktopColumns: 4,
  children: products.map((p) => ProductCard(product: p)).toList(),
)

// Fixed 2 column
YoGrid.twoColumn(
  context: context,
  children: items.map((i) => ItemCard(item: i)).toList(),
)
```

---

### YoGridItem

Item untuk YoGrid dengan styling.

**Constructors:**
- `YoGridItem()` - Default
- `YoGridItem.card()` - Card style

**Parameters:**

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `child` | `Widget` | required | Widget child |
| `backgroundColor` | `Color?` | `null` | Warna background |
| `padding` | `EdgeInsets` | `all(16)` | Padding |
| `borderRadius` | `BorderRadius` | `zero` | Border radius |
| `border` | `BoxBorder?` | `null` | Border |
| `shadow` | `List<BoxShadow>?` | `null` | Shadow |

**Contoh Penggunaan:**

```dart
YoGridItem.card(
  context: context,
  child: Column(
    children: [
      Icon(Icons.analytics, size: 48),
      Text('Analytics'),
    ],
  ),
)
```

---

### YoMasonryGrid

Grid dengan tinggi bervariasi (Pinterest-style).

**Constructors:**
- `YoMasonryGrid()` - Default
- `YoResponsiveMasonryGrid()` - Responsive

**Parameters:**

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `children` | `List<Widget>` | required | Widget children |
| `columns` | `int` | `2` | Jumlah kolom |
| `spacing` | `double` | `8` | Jarak horizontal |
| `runSpacing` | `double` | `8` | Jarak vertikal |
| `padding` | `EdgeInsetsGeometry?` | `null` | Padding |

**Contoh Penggunaan:**

```dart
YoMasonryGrid(
  columns: 2,
  spacing: 12,
  runSpacing: 12,
  children: images.map((url) => Image.network(url)).toList(),
)

// Responsive masonry
YoResponsiveMasonryGrid(
  spacing: 12,
  children: cards,
)
```

---

### YoSpace

Widget spasi adaptif.

**Constructors:**
- `YoSpace()` - Default
- `YoSpace.width(double w)` - Lebar saja
- `YoSpace.height(double h)` - Tinggi saja
- `YoSpace.xs/sm/md/lg/xl` - Static sizes
- `YoSpace.widthXs/widthSm/...` - Width static
- `YoSpace.heightXs/heightSm/...` - Height static
- `YoSpace.adaptiveXs/adaptiveSm/...` - Adaptive sizes

**Contoh Penggunaan:**

```dart
Column(
  children: [
    Text('Title'),
    YoSpace.heightMd(), // 16px
    Text('Description'),
    YoSpace.heightSm(), // 8px
    Text('Footer'),
  ],
)

// Adaptive spacing
Row(
  children: [
    Icon(Icons.home),
    YoSpace.adaptiveMd(), // 16/20/24 based on screen
    Text('Home'),
  ],
)
```

---

### YoBox

SizedBox dengan helper expand.

**Constructors:**
- `YoBox()` - Default
- `YoBox.expand()` - Full width & height
- `YoBox.expandWidth()` - Full width
- `YoBox.expandHeight()` - Full height

**Contoh Penggunaan:**

```dart
YoBox.expandWidth(
  height: 100,
  child: Card(child: Text('Full width card')),
)
```

---

## Utility Components

Komponen utilitas.

### YoInfiniteScroll

List dengan lazy loading otomatis.

**Parameters:**

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `itemCount` | `int` | required | Jumlah item saat ini |
| `itemBuilder` | `IndexedWidgetBuilder` | required | Builder item |
| `onLoadMore` | `Future<void> Function()` | required | Callback load more |
| `hasMore` | `bool` | `true` | Ada item lagi |
| `loadingWidget` | `Widget?` | `null` | Custom loading |
| `threshold` | `double` | `200` | Jarak trigger load |
| `physics` | `ScrollPhysics?` | `null` | Scroll physics |
| `padding` | `EdgeInsetsGeometry?` | `null` | Padding |
| `emptyWidget` | `Widget?` | `null` | Widget saat kosong |
| `controller` | `ScrollController?` | `null` | Scroll controller |

**Contoh Penggunaan:**

```dart
YoInfiniteScroll(
  itemCount: products.length,
  hasMore: hasMoreProducts,
  onLoadMore: () => loadMoreProducts(),
  emptyWidget: YoEmptyState.noData(),
  itemBuilder: (context, index) {
    return ProductCard(product: products[index]);
  },
)
```

---

### YoResponsiveBuilder

Builder dengan info screen size.

**Parameters:**

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `builder` | `Function(BuildContext, ScreenSize)` | required | Builder function |
| `fallback` | `Widget?` | `null` | Fallback widget |

**Contoh Penggunaan:**

```dart
YoResponsiveBuilder(
  builder: (context, screenSize) {
    return Text('Screen: $screenSize');
  },
)
```

---

### YoResponsiveLayout

Layout berbeda untuk setiap screen size.

**Parameters:**

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `mobile` | `Widget` | required | Widget untuk mobile |
| `tablet` | `Widget?` | `null` | Widget untuk tablet |
| `desktop` | `Widget?` | `null` | Widget untuk desktop |

**Contoh Penggunaan:**

```dart
YoResponsiveLayout(
  mobile: MobileLayout(),
  tablet: TabletLayout(),
  desktop: DesktopLayout(),
)
```

---

### YoAnimatedSwitch

Widget switcher dengan animasi.

**Parameters:**

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `condition` | `bool` | required | Kondisi |
| `trueChild` | `Widget` | required | Widget jika true |
| `falseChild` | `Widget` | required | Widget jika false |
| `duration` | `Duration` | `300ms` | Durasi animasi |
| `curve` | `Curve` | `easeInOut` | Curve animasi |

**Contoh Penggunaan:**

```dart
YoAnimatedSwitch(
  condition: isLoggedIn,
  trueChild: UserAvatar(),
  falseChild: LoginButton(),
)
```

---

### YoAnimatedCrossSwitch

CrossFade switcher dengan animasi.

**Parameters:**

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `condition` | `bool` | required | Kondisi |
| `firstChild` | `Widget` | required | Widget pertama |
| `secondChild` | `Widget` | required | Widget kedua |
| `duration` | `Duration` | `300ms` | Durasi animasi |
| `curve` | `Curve` | `easeInOut` | Curve animasi |

**Contoh Penggunaan:**

```dart
YoAnimatedCrossSwitch(
  condition: isLoading,
  firstChild: YoLoading(),
  secondChild: Content(),
)
```

---

## Quick Reference

### Import

```dart
import 'package:yo_ui/yo_ui.dart';
```

### Component Categories

| Category | Count | Examples |
|----------|-------|----------|
| Display | 23 | YoAvatar, YoChart, YoTimeline, YoKanban |
| Form | 12 | YoTextFormField, YoDropDown, YoOtpField |
| Feedback | 18 | YoToast, YoDialog, YoLoading, YoSkeleton |
| Navigation | 8 | YoAppBar, YoBottomNav, YoSidebar, YoStepper |
| Picker | 11 | YoDatePicker, YoColorPicker, YoFilePicker |
| Layout | 4 | YoGrid, YoMasonryGrid, YoSpace |
| Utility | 4 | YoInfiniteScroll, YoResponsiveBuilder |

---

*YoUI Flutter Package v1.1.4 - Build Beautiful Apps Faster*
