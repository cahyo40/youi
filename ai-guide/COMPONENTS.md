# YoUI Components - AI Skill Reference

> **Category**: UI Components (80+ widgets)
> **Purpose**: Ready-to-use widgets for Flutter apps with YoUI
> **Auto Theme**: All components support Light/Dark mode automatically

---

## COMPONENT INDEX

| Category | Widgets |
|----------|---------|
| **Basic** | YoScaffold, YoIconButton |
| **Display** | YoAvatar, YoBadge, YoChip, YoRating, YoText, YoCarousel, YoTimeline, YoChart, YoDataTable, YoCalendar, YoKanbanBoard, YoChatBubble, YoComment, YoProductCard, YoArticleCard, YoProfileCard, YoDestinationCard, YoListTile |
| **Form** | YoTextFormField, YoSearchField, YoDropDown, YoOtpField, YoChipInput, YoSlider, YoRangeSlider, YoCheckbox, YoRadio, YoSwitch, YoForm |
| **Feedback** | YoToast, YoSnackBar, YoDialog, YoBottomSheet, YoLoading, YoSkeleton, YoEmptyState, YoProgressIndicator |
| **Navigation** | YoAppBar, YoBottomNav, YoSidebar, YoStepper, YoTabBar |
| **Picker** | YoDatePicker, YoDateRangePicker, YoTimePicker, YoColorPicker, YoFilePicker, YoImagePicker |
| **Layout** | YoGrid, YoMasonryGrid, YoSpace |
| **Utility** | YoInfiniteScroll, YoResponsiveBuilder |

---

## BASIC COMPONENTS

### YoScaffold

```dart
YoScaffold(
  appBar: YoAppBar(title: 'Home'),
  body: Center(child: Text('Hello World')),
  floatingActionButton: FloatingActionButton(onPressed: () {}, child: Icon(Icons.add)),
)
```

### YoIconButton

```dart
YoIconButton(
  icon: Icons.favorite,
  onPressed: () => print('Liked!'),
  color: context.errorColor,
  size: 24,
)
```

---

## DISPLAY COMPONENTS

### YoAvatar

**Constructors**: `YoAvatar()`, `.icon()`, `.image()`, `.asset()`, `.file()`, `.text()`

| Parameter | Type | Description |
|-----------|------|-------------|
| `imageUrl` | String? | Network image URL |
| `text` | String? | Text for initials |
| `icon` | IconData? | Icon to display |
| `size` | YoAvatarSize | xs/sm/md/lg/xl |
| `variant` | YoAvatarVariant | circle/rounded/square |
| `showBadge` | bool | Show status badge |

```dart
YoAvatar.image(imageUrl: 'https://...', size: YoAvatarSize.lg, showBadge: true)
YoAvatar.text(text: 'John Doe', backgroundColor: context.primaryColor)
YoAvatar.icon(icon: Icons.person, size: YoAvatarSize.xl)
```

### YoAvatarOverlap

```dart
YoAvatarOverlap(
  imageUrls: ['url1', 'url2', 'url3', 'url4', 'url5'],
  maxDisplay: 3,
  size: YoAvatarSize.sm,
  onTapMore: () => showAllMembers(),
)
```

### YoBadge

**Constructors**: `YoBadge()`, `.primary()`, `.success()`, `.warning()`, `.error()`, `.outline()`, `.dot()`

```dart
YoBadge.success(text: 'Active')
YoBadge.error(text: 'Failed')
YoBadge(text: 'New', icon: Icon(Icons.star, size: 12), variant: YoBadgeVariant.primary)
```

### YoChip

**Constructors**: `YoChip()`, `.primary()`, `.success()`, `.error()`, `.warning()`, `.info()`

```dart
YoChip(label: 'Flutter', onDeleted: () => removeTag('Flutter'))
YoChip(label: 'Category', selected: isSelected, onTap: () => toggleSelection())
YoChip.success(label: 'Completed')
```

### YoRating

**Constructors**: `YoRating()`, `YoRatingStars()`, `YoRatingInteractive()`, `YoRatingSummary()`

```dart
YoRating(initialRating: 3.5, allowHalfRating: true, onRatingUpdate: (r) => saveRating(r))
YoRatingSummary(rating: 4.2, totalRatings: 1250, showBreakdown: true)
```

### YoText

**Methods**: `displayLarge/Medium/Small`, `headlineLarge/Medium/Small`, `titleLarge/Medium/Small`, `bodyLarge/Medium/Small`, `labelLarge/Medium/Small`, `monoLarge/Medium/Small`

```dart
YoText.headlineMedium('Welcome Back')
YoText.bodyLarge('Dashboard overview')
YoText.monoMedium('Order #ORD-001')
```

### YoCarousel

```dart
YoCarousel(
  height: 200,
  autoPlay: true,
  autoPlayInterval: Duration(seconds: 5),
  items: [Image.network('url1'), Image.network('url2')],
  onPageChanged: (index) => print('Page: $index'),
)
```

### YoTimeline

```dart
YoTimeline(
  events: [
    YoTimelineEvent(title: 'Order Placed', description: 'Received', isCompleted: true),
    YoTimelineEvent(title: 'Processing', description: 'Being prepared', isActive: true),
    YoTimelineEvent(title: 'Shipped'),
    YoTimelineEvent(title: 'Delivered'),
  ],
)
```

### YoChart

**Types**: `YoLineChart()`, `YoLineChart.simple()`, `YoBarChart()`, `YoPieChart()`, `YoPieChart.donut()`, `YoSparkLine()`

```dart
YoLineChart(
  title: 'Revenue 2026',
  dataSets: [[YoChartData(x: 1, y: 1000), YoChartData(x: 2, y: 1500)]],
  curved: true,
  filled: true,
)

YoPieChart.donut(
  centerText: '75%',
  data: [YoPieData(value: 40, label: 'A'), YoPieData(value: 30, label: 'B')],
)

YoSparkLine(data: [10, 25, 18, 30], height: 40, width: 120, color: context.successColor)
```

### YoDataTable

```dart
YoDataTable(
  columns: [
    YoTableColumn(label: 'ID', width: 80, sortable: true),
    YoTableColumn(label: 'Name', sortable: true),
    YoTableColumn(label: 'Price', numeric: true),
  ],
  rows: products.map((p) => YoTableRow(
    cells: [p.id, p.name, p.price.toString()],
    onTap: () => viewProduct(p),
  )).toList(),
  selectable: true,
)
```

### YoCalendar

```dart
YoCalendar(
  events: [
    YoCalendarEvent(id: '1', title: 'Meeting', startTime: DateTime(...), endTime: DateTime(...), color: Colors.blue),
  ],
  onEventTap: (event) => showEventDetails(event),
)
```

### YoKanbanBoard

```dart
YoKanbanBoard(
  height: 500,
  columns: [
    YoKanbanColumn(id: 'todo', title: 'To Do', items: [YoKanbanItem(id: '1', title: 'Task')]),
    YoKanbanColumn(id: 'progress', title: 'In Progress', items: []),
    YoKanbanColumn(id: 'done', title: 'Done', items: []),
  ],
  onItemMoved: (item, fromColumn, toColumn) => print('Moved'),
)
```

### YoChatBubble / YoChatList

```dart
YoChatList(
  messages: [
    YoChatMessage(id: '1', text: 'Hello!', isSentByMe: false, senderName: 'John'),
    YoChatMessage(id: '2', text: 'Hi!', isSentByMe: true, status: YoMessageStatus.read),
  ],
)
```

### YoProductCard

**Constructors**: `YoProductCard.grid()`, `.list()`, `.pos()`

| Parameter | Type | Description |
|-----------|------|-------------|
| `imageUrl` | String? | Product image URL |
| `title` | String | Product name |
| `price` | double | Current price |
| `originalPrice` | double? | Original price (for discount) |
| `rating` | double? | Star rating (0-5) |
| `badge` | String? | Badge text (e.g., 'Sale') |
| `currencySymbol` | String | Currency symbol (default 'Rp ') |
| `stock` | int? | Stock quantity (for POS) |
| `onAddToCart` | VoidCallback? | Add to cart callback |
| `onTap` | VoidCallback? | Card tap callback |

```dart
YoProductCard.grid(
  imageUrl: 'https://...',
  title: 'Wireless Headphones',
  price: 99.99,
  originalPrice: 149.99,
  rating: 4.5,
  badge: 'Sale',
  onAddToCart: () => addToCart(),
)

YoProductCard.pos(title: 'Coffee', price: 25000, currencySymbol: 'Rp ', stock: 50)
```

### YoArticleCard

**Constructors**: `YoArticleCard()`, `.horizontal()`, `.featured()`

| Parameter | Type | Description |
|-----------|------|-------------|
| `imageUrl` | String? | Article image |
| `title` | String | Article title |
| `excerpt` | String? | Article excerpt/summary |
| `category` | String? | Category name |
| `authorName` | String? | Author name |
| `authorAvatarUrl` | String? | Author avatar |
| `publishedAt` | DateTime? | Published date |
| `readTime` | int? | Read time in minutes |
| `onTap` | VoidCallback? | Card tap callback |

```dart
YoArticleCard.featured(
  imageUrl: 'https://...',
  title: 'Flutter Development',
  excerpt: 'Explore trends...',
  category: 'Technology',
  authorName: 'Jane',
  publishedAt: DateTime.now(),
  readTime: 8,
)
```

### YoProfileCard

**Constructors**: `YoProfileCard()`, `.compact()`, `.cover()`

| Parameter | Type | Description |
|-----------|------|-------------|
| `avatarUrl` | String? | Profile avatar |
| `name` | String | Display name |
| `subtitle` | String? | Subtitle (e.g., username) |
| `bio` | String? | Bio text |
| `isVerified` | bool | Show verified badge |
| `isFollowing` | bool | Following state |
| `stats` | List<YoProfileStat>? | Profile statistics |
| `onFollow` | VoidCallback? | Follow button callback |
| `onMessage` | VoidCallback? | Message button callback |

```dart
YoProfileCard(
  avatarUrl: 'https://...',
  name: 'John Doe',
  subtitle: '@johndoe',
  isVerified: true,
  stats: [YoProfileStat(value: '1.2K', label: 'Posts')],
  onFollow: () => toggleFollow(),
)
```

### YoListTile

**Constructors**: `YoListTile()`, `.simple()`, `YoListTileWithAvatar()`, `YoListTileWithSwitch()`

```dart
YoListTileWithSwitch(
  title: 'Dark Mode',
  subtitle: 'Enable dark theme',
  icon: Icons.dark_mode,
  value: isDarkMode,
  onChanged: (value) => toggleDarkMode(value),
)

YoListTileWithAvatar(
  imageUrl: 'https://...',
  title: 'John Doe',
  subtitle: 'Hello!',
  timestamp: '2m ago',
  hasUnread: true,
  isOnline: true,
)
```

---

## FORM COMPONENTS

### YoTextFormField

| Parameter | Type | Description |
|-----------|------|-------------|
| `labelText` | String? | Field label |
| `hintText` | String? | Placeholder text |
| `helperText` | String? | Helper text below field |
| `inputType` | YoInputType | text/email/password/phone/number/url/search/multiline/currency |
| `inputStyle` | YoInputStyle | outlined/filled/underline/floating/modern |
| `isRequired` | bool | Mark as required |
| `showVisibilityToggle` | bool | Toggle password visibility |
| `showClearButton` | bool | Show clear button |
| `inputFormatters` | List | Text formatters |
| `prefixIcon` | IconData? | Prefix icon |
| `suffixIcon` | IconData? | Suffix icon |
| `maxLines` | int | Maximum lines (default 1) |
| `maxLength` | int? | Maximum character length |
| `controller` | TextEditingController? | Text controller |
| `validator` | String? Function(String?)? | Validation function |
| `onChanged` | Function(String)? | On text change callback |
| `onSubmitted` | Function(String)? | On submit callback |

**YoInputType Values**:

- `text` - Standard text input
- `email` - Email with @ keyboard
- `password` - Obscured input
- `phone` - Phone number keyboard
- `number` - Numeric keyboard
- `url` - URL keyboard
- `search` - Search with action button
- `multiline` - Multi-line text area
- `currency` - Numeric with decimal

**YoInputStyle Values**:

- `outlined` - Border around field
- `filled` - Filled background
- `underline` - Bottom border only
- `floating` - Floating label
- `modern` - Modern rounded style

```dart
YoTextFormField(labelText: 'Email', inputType: YoInputType.email, isRequired: true)
YoTextFormField(labelText: 'Password', inputType: YoInputType.password, showVisibilityToggle: true)
YoTextFormField(labelText: 'Price', inputFormatters: [IndonesiaCurrencyFormatter()])
YoTextFormField(labelText: 'Description', inputType: YoInputType.multiline, maxLines: 4)
```

### YoSearchField

| Parameter | Type | Description |
|-----------|------|-------------|
| `hintText` | String? | Placeholder text |
| `suggestions` | List<String>? | Search suggestions |
| `debounceMs` | int | Debounce delay (default 300) |
| `showClearButton` | bool | Show clear button |
| `onSearch` | Function(String)? | Search callback |
| `onSuggestionTap` | Function(String)? | Suggestion tap callback |

```dart
YoSearchField(
  hintText: 'Search products...',
  suggestions: ['iPhone', 'Samsung'],
  debounceMs: 500,
  onSearch: (query) => searchProducts(query),
)
```

### YoDropDown<T>

| Parameter | Type | Description |
|-----------|------|-------------|
| `labelText` | String? | Field label |
| `hintText` | String? | Placeholder text |
| `value` | T? | Current selected value |
| `items` | List<YoDropDownItem<T>> | Dropdown items |
| `isRequired` | bool | Mark as required |
| `isSearchable` | bool | Enable search in dropdown |
| `isDisabled` | bool | Disable the field |
| `onChanged` | Function(T?)? | On change callback |

**YoDropDownItem<T>**:

- `value` - Item value
- `label` - Display label
- `leading` - Leading widget (icon/image)
- `subtitle` - Subtitle text

```dart
YoDropDown<String>(
  labelText: 'Category',
  hintText: 'Select category',
  value: selectedCategory,
  isRequired: true,
  items: [
    YoDropDownItem(value: 'electronics', label: 'Electronics', leading: Icon(Icons.devices)),
    YoDropDownItem(value: 'clothing', label: 'Clothing'),
  ],
  onChanged: (value) => setState(() => selectedCategory = value),
)
```

### YoOtpField

| Parameter | Type | Description |
|-----------|------|-------------|
| `length` | int | Number of OTP digits (default 6) |
| `obscureText` | bool | Hide input (default false) |
| `autoFocus` | bool | Auto focus first field |
| `onCompleted` | Function(String) | Called when OTP is complete |
| `onChanged` | Function(String)? | Called on each change |

```dart
YoOtpField(
  length: 6,
  onCompleted: (otp) => verifyOtp(otp),
)
```

### YoChipInput

| Parameter | Type | Description |
|-----------|------|-------------|
| `chips` | List<String> | Current chips |
| `suggestions` | List<String>? | Available suggestions |
| `maxChips` | int? | Maximum chips allowed |
| `labelText` | String? | Field label |
| `hintText` | String? | Placeholder text |
| `onChanged` | Function(List<String>) | On chips change callback |

```dart
YoChipInput(
  chips: ['Flutter', 'Dart'],
  suggestions: ['React', 'Vue', 'Angular'],
  maxChips: 5,
  onChanged: (chips) => setState(() => selectedTags = chips),
)
```

### YoSlider / YoRangeSlider

| Parameter | Type | Description |
|-----------|------|-------------|
| `value` / `values` | double / RangeValues | Current value(s) |
| `min` | double | Minimum value |
| `max` | double | Maximum value |
| `divisions` | int? | Number of divisions |
| `label` | String? | Value label |
| `showLabels` | bool | Show min/max labels |
| `onChanged` | Function | Value change callback |

```dart
YoSlider(value: volume, min: 0, max: 100, divisions: 10, onChanged: (v) => setState(() => volume = v))

YoRangeSlider(
  values: RangeValues(minPrice, maxPrice),
  min: 0,
  max: 10000000,
  onChanged: (range) => setState(() { minPrice = range.start; maxPrice = range.end; }),
)
```

### YoCheckbox / YoRadio / YoSwitch

| Parameter | Type | Description |
|-----------|------|-------------|
| `value` | bool / T | Current value |
| `groupValue` | T? | Radio group value |
| `label` | String? | Label text |
| `subtitle` | String? | Subtitle text |
| `isDisabled` | bool | Disable the control |
| `onChanged` | Function | Value change callback |

```dart
YoCheckbox(value: agreeTerms, label: 'I agree to Terms', onChanged: (v) => setState(() => agreeTerms = v ?? false))

YoRadio<String>(value: 'male', groupValue: gender, label: 'Male', onChanged: (v) => setState(() => gender = v))

YoSwitch(value: isDarkMode, label: 'Dark Mode', onChanged: (v) => toggleTheme(v))
```

### YoForm

```dart
final formController = YoFormController();

YoForm(
  formKey: formController.formKey,
  children: [
    YoTextFormField(labelText: 'Name', isRequired: true),
    YoButton(text: 'Submit', onPressed: () {
      if (formController.submit()) { /* Valid */ }
    }),
  ],
)
```

---

## FEEDBACK COMPONENTS

### YoToast

| Parameter | Type | Description |
|-----------|------|-------------|
| `context` | BuildContext | Build context |
| `message` | String | Toast message |
| `duration` | Duration? | Display duration |
| `onTap` | VoidCallback? | Tap callback |

```dart
YoToast.success(context, 'Data saved!')
YoToast.error(context, 'Failed to save', duration: Duration(seconds: 5))
YoToast.warning(context, 'Session expiring', onTap: () => extendSession())
YoToast.info(context, 'New update available')
```

### YoDialog

| Parameter | Type | Description |
|-----------|------|-------------|
| `context` | BuildContext | Build context |
| `title` | String? | Dialog title |
| `message` | String? | Dialog message |
| `confirmText` | String? | Confirm button text |
| `cancelText` | String? | Cancel button text |
| `onConfirm` | VoidCallback? | Confirm callback |
| `onCancel` | VoidCallback? | Cancel callback |
| `child` | Widget? | Custom content (for .custom) |

```dart
YoDialog.confirm(
  context,
  title: 'Confirm Delete',
  message: 'Are you sure?',
  confirmText: 'Delete',
  onConfirm: () => deleteItem(),
)

YoDialog.custom(context, child: CustomDialogContent())
```

### YoBottomSheet

```dart
YoBottomSheet.show(context, child: OptionsContent())
YoBottomSheet.scrollable(context, child: LongContent())
```

### YoLoading

```dart
YoLoading.show(context, message: 'Loading...')
YoLoadingOverlay(isLoading: isSubmitting, message: 'Saving...', child: FormContent())
```

### YoSkeleton

| Type | Description |
|------|-------------|
| `YoSkeletonCard` | Card with optional image, title, text |
| `YoSkeletonList` | List of skeleton items |
| `YoSkeletonText` | Text lines skeleton |
| `YoSkeletonAvatar` | Avatar skeleton |

```dart
YoSkeletonCard(hasImage: true, hasTitle: true)
YoSkeletonList(itemCount: 5)
YoSkeletonText(lines: 3)
```

### YoEmptyState

**Constructors**: `YoEmptyState()`, `.noData()`, `.noConnection()`, `.error()`, `.searchNotFound()`, `.custom()`

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `title` | String | required | Title text |
| `description` | String | required | Description message |
| `icon` | Widget? | null | Custom icon/image widget |
| `actionText` | String? | null | Primary action button text |
| `onAction` | VoidCallback? | null | Primary action callback |
| `secondaryActionText` | String? | null | Secondary action button text |
| `onSecondaryAction` | VoidCallback? | null | Secondary action callback |
| `type` | YoEmptyStateType | general | State type (affects icon color) |
| `error` | Object? | null | Error object (for .error()) |
| `showErrorDetails` | bool | false | Show error details box |

**YoEmptyStateType Values**:

- `general` - Primary color icon
- `noData` - Gray icon
- `noConnection` - Warning color icon
- `error` - Error color with background circle
- `search` - Gray icon

```dart
// Basic
YoEmptyState(
  title: 'Empty Cart',
  description: 'Start adding products to your cart',
  icon: Icon(Icons.shopping_cart_outlined),
  actionText: 'Browse Products',
  onAction: () => navigateToProducts(),
)

// No Data (Indonesian default text)
YoEmptyState.noData(
  title: 'Tidak ada data',  // default
  description: 'Data yang Anda cari tidak ditemukan',  // default
  actionText: 'Tambah Data',
  onAction: () => addData(),
)

// No Connection
YoEmptyState.noConnection(
  title: 'Tidak ada koneksi',  // default
  description: 'Periksa koneksi internet Anda dan coba lagi',  // default
  actionText: 'Coba Lagi',  // default
  onAction: () => retry(),
)

// Error State (with optional error details)
YoEmptyState.error(
  title: 'Terjadi kesalahan',  // default
  description: 'Maaf, terjadi kesalahan. Silakan coba lagi',  // default
  actionText: 'Coba Lagi',  // default
  onAction: () => retry(),
  error: exception,  // optional
  showErrorDetails: true,  // show error.toString() in box
)

// Search Not Found
YoEmptyState.searchNotFound(
  title: 'Tidak ditemukan',  // default
  description: 'Coba gunakan kata kunci lain',  // default
  actionText: 'Reset Pencarian',
  onAction: () => resetSearch(),
)

// Custom with Image
YoEmptyState.custom(
  title: 'Welcome!',
  description: 'Get started by creating your first item',
  image: Image.asset('assets/welcome.png', height: 120),
  actionText: 'Get Started',
  onAction: () => getStarted(),
)

// With Secondary Action
YoEmptyState.error(
  title: 'Connection Failed',
  description: 'Unable to connect to server',
  actionText: 'Retry',
  onAction: () => retry(),
  secondaryActionText: 'Go Offline',
  onSecondaryAction: () => goOffline(),
)
```

---

## NAVIGATION COMPONENTS

### YoAppBar

```dart
YoAppBar(title: 'Dashboard', actions: [IconButton(...)])
```

### YoBottomNav

| Parameter | Type | Description |
|-----------|------|-------------|
| `currentIndex` | int | Current selected index |
| `items` | List<YoBottomNavItem> | Navigation items |
| `onTap` | Function(int) | Tap callback |
| `type` | YoBottomNavType | fixed/shifting |

```dart
YoBottomNav(
  currentIndex: selectedIndex,
  items: [
    YoBottomNavItem(icon: Icons.home, label: 'Home'),
    YoBottomNavItem(icon: Icons.search, label: 'Search'),
    YoBottomNavItem(icon: Icons.person, label: 'Profile'),
  ],
  onTap: (index) => setState(() => selectedIndex = index),
)
```

### YoStepper

| Parameter | Type | Description |
|-----------|------|-------------|
| `currentStep` | int | Current active step |
| `steps` | List<YoStep> | Step items |
| `type` | StepperType | horizontal/vertical |
| `onStepContinue` | VoidCallback? | Continue callback |
| `onStepCancel` | VoidCallback? | Cancel callback |
| `onStepTapped` | Function(int)? | Step tap callback |

```dart
YoStepper(
  currentStep: currentStep,
  steps: [
    YoStep(title: 'Info', content: InfoForm()),
    YoStep(title: 'Payment', content: PaymentForm()),
    YoStep(title: 'Confirm', content: ConfirmView()),
  ],
  onStepContinue: () => nextStep(),
  onStepCancel: () => prevStep(),
)
```

---

## PICKER COMPONENTS

### YoDatePicker / YoDateRangePicker

| Parameter | Type | Description |
|-----------|------|-------------|
| `labelText` | String? | Field label |
| `selectedDate` / `selectedRange` | DateTime? / DateTimeRange? | Selected value |
| `firstDate` | DateTime? | Earliest selectable date |
| `lastDate` | DateTime? | Latest selectable date |
| `onDateChanged` / `onRangeChanged` | Function | Change callback |

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

### YoTimePicker

```dart
YoTimePicker(
  labelText: 'Meeting Time',
  selectedTime: meetingTime,
  onTimeChanged: (time) => setState(() => meetingTime = time),
)
```

### YoFilePicker / YoImagePicker

| Parameter | Type | Description |
|-----------|------|-------------|
| `allowedExtensions` | List<String>? | Allowed file extensions |
| `allowMultiple` | bool | Allow multiple files |
| `maxSize` | int? | Max file size in bytes |
| `onFileSelected` | Function(File) | File selected callback |
| `showPreview` | bool | Show image preview (ImagePicker) |

```dart
YoFilePicker(
  allowedExtensions: ['pdf', 'doc'],
  onFileSelected: (file) => uploadFile(file),
)

YoImagePicker(
  onImageSelected: (file) => uploadImage(file),
  showPreview: true,
)
```

---

## LAYOUT COMPONENTS

### YoGrid

| Parameter | Type | Description |
|-----------|------|-------------|
| `context` | BuildContext | Build context |
| `phoneColumns` | int | Columns on phone (default 2) |
| `tabletColumns` | int | Columns on tablet (default 3) |
| `desktopColumns` | int | Columns on desktop (default 4) |
| `spacing` | double | Grid spacing |
| `children` | List<Widget> | Grid children |

```dart
YoGrid.responsive(
  context: context,
  phoneColumns: 2,
  tabletColumns: 3,
  desktopColumns: 4,
  spacing: 16,
  children: [...],
)
```

### YoSpace

```dart
YoSpace.heightXs()   // 4
YoSpace.heightSm()   // 8
YoSpace.heightMd()   // 16
YoSpace.heightLg()   // 24
YoSpace.heightXl()   // 32

YoSpace.widthXs()    // 4
YoSpace.widthSm()    // 8
YoSpace.widthMd()    // 16
YoSpace.widthLg()    // 24
YoSpace.widthXl()    // 32
```

---

## UTILITY COMPONENTS

### YoInfiniteScroll

| Parameter | Type | Description |
|-----------|------|-------------|
| `itemCount` | int | Current item count |
| `hasMore` | bool | Has more items to load |
| `onLoadMore` | VoidCallback | Load more callback |
| `itemBuilder` | Widget Function(BuildContext, int) | Item builder |
| `loadingWidget` | Widget? | Loading indicator widget |

```dart
YoInfiniteScroll(
  itemCount: items.length,
  hasMore: hasMoreItems,
  onLoadMore: () => loadMoreItems(),
  itemBuilder: (context, index) => ItemWidget(items[index]),
)
```

### YoResponsiveBuilder

| Parameter | Type | Description |
|-----------|------|-------------|
| `mobile` | Widget | Mobile layout widget |
| `tablet` | Widget? | Tablet layout widget |
| `desktop` | Widget? | Desktop layout widget |

```dart
YoResponsiveBuilder(
  mobile: MobileLayout(),
  tablet: TabletLayout(),
  desktop: DesktopLayout(),
)
```
