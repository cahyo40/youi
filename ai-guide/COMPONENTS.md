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
| `inputType` | YoInputType | text/email/password/phone/number/url/search/multiline/currency |
| `inputStyle` | YoInputStyle | outlined/filled/underline/floating/modern |
| `isRequired` | bool | Mark as required |
| `showVisibilityToggle` | bool | Toggle password visibility |
| `showClearButton` | bool | Show clear button |
| `inputFormatters` | List | Text formatters |

```dart
YoTextFormField(labelText: 'Email', inputType: YoInputType.email, isRequired: true)
YoTextFormField(labelText: 'Password', inputType: YoInputType.password, showVisibilityToggle: true)
YoTextFormField(labelText: 'Price', inputFormatters: [IndonesiaCurrencyFormatter()])
```

### YoSearchField
```dart
YoSearchField(
  hintText: 'Search products...',
  suggestions: ['iPhone', 'Samsung'],
  debounceMs: 500,
  onSearch: (query) => searchProducts(query),
)
```

### YoDropDown<T>
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
```dart
YoOtpField(
  length: 6,
  onCompleted: (otp) => verifyOtp(otp),
)
```

### YoChipInput
```dart
YoChipInput(
  chips: ['Flutter', 'Dart'],
  suggestions: ['React', 'Vue', 'Angular'],
  maxChips: 5,
  onChanged: (chips) => setState(() => selectedTags = chips),
)
```

### YoSlider / YoRangeSlider
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
```dart
YoToast.success(context, 'Data saved!')
YoToast.error(context, 'Failed to save', duration: Duration(seconds: 5))
YoToast.warning(context, 'Session expiring', onTap: () => extendSession())
YoToast.info(context, 'New update available')
```

### YoDialog
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
```dart
YoSkeletonCard(hasImage: true, hasTitle: true)
YoSkeletonList(itemCount: 5)
YoSkeletonText(lines: 3)
```

### YoEmptyState
```dart
YoEmptyState(
  icon: Icons.inbox,
  title: 'No Data',
  message: 'Start adding items',
  actionText: 'Add Item',
  onAction: () => addItem(),
)
```

---

## NAVIGATION COMPONENTS

### YoAppBar
```dart
YoAppBar(title: 'Dashboard', actions: [IconButton(...)])
```

### YoBottomNav
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

YoSpace.widthSm()    // Horizontal space
```

---

## UTILITY COMPONENTS

### YoInfiniteScroll
```dart
YoInfiniteScroll(
  itemCount: items.length,
  hasMore: hasMoreItems,
  onLoadMore: () => loadMoreItems(),
  itemBuilder: (context, index) => ItemWidget(items[index]),
)
```

### YoResponsiveBuilder
```dart
YoResponsiveBuilder(
  mobile: MobileLayout(),
  tablet: TabletLayout(),
  desktop: DesktopLayout(),
)
```
