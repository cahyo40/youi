# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.1.3] - 2025-12-22

### Added
- **YoImagePicker** - Comprehensive image picker utility
  - Pick from camera or gallery
  - Multiple image selection support
  - Video and media picking
  - Source picker dialogs (bottom sheet & dialog)
  - **YoImagePickerConfig** presets: `defaultConfig`, `compressed`, `highQuality`, `thumbnail`, `avatar`
  - **YoImagePickerButton** - Button widget with image preview
  - **YoAvatarPicker** - Circular avatar picker with edit indicator

- **YoFilePicker** - Complete file picker utility
  - Pick any file type (images, videos, audio, documents)
  - Multiple file selection
  - Directory picking (desktop/mobile)
  - Save file dialog
  - **YoFileType** enum: `any`, `media`, `image`, `video`, `audio`, `custom`
  - **YoFileHelper** - File utilities (format size, get icon/color by extension)
  - **YoFilePickerButton** - Button widget with file info display
  - **YoFileDropZone** - Drag & drop zone for file uploads
  - **YoFileListTile** - List tile for displaying picked files

### Dependencies
- Added `image_picker: ^1.1.2` for camera/gallery picking
- Added `file_picker: ^8.1.7` for file system picking

---

## [1.1.2] - 2025-12-22

### Added
- **YoIconPicker** - Comprehensive icon picker component with 200+ categorized Material icons
  - **18 Categories**: Action, Alert, Audio/Video, Communication, Content, Device, Editor, File, Hardware, Home, Image, Maps, Navigation, Notification, Places, Social, Toggle
  - **Search functionality** for quick icon lookup
  - **Category tabs** for organized browsing
  - **Multiple display modes**:
    - Inline widget (`YoIconPicker`)
    - Bottom sheet (`YoIconPicker.showAsBottomSheet()`)
    - Dialog (`YoIconPicker.showAsDialog()`)
  - **YoIconPickerButton** - Button that triggers picker on tap
  - **YoIcons** - Static icon library with category filtering and search
  - **YoIconCategory** enum for icon categorization
  - **YoIconData** model with icon, name, and category

---

## [1.1.1] - 2025-12-22

### Added
- **YoDateRangePicker** - New date range picker component with default and compact layout variants
  - Default layout with single-field date range display
  - Compact layout with separate start/end date fields
  - Integration with `YoDialogPicker.dateRange()`

### Fixed
- Added missing `crypto` package dependency for `YoIdGenerator` hash functions (MD5, SHA1, SHA256)
- Fixed lint issues:
  - Removed deprecated `library yo_ui;` statement (now uses `library;`)
  - Fixed curly braces in flow control structures in `yo_icon_button.dart`
  - Removed unnecessary string interpolation in `yo_chart.dart`
  - Removed unnecessary imports in `yo_skeleton_grid.dart` and `yo_progress.dart`
  - Fixed unnecessary brace in string interpolation in `yo_date_formatter.dart`

### Dependencies
- Added `crypto: ^3.0.6` for hash ID generation

---

## [1.1.0] - 2025-12-07

### Added - New Components
- **Charts** (`YoLineChart`, `YoBarChart`, `YoPieChart`, `YoSparkLine`) - using fl_chart
- **YoProductCard** - E-commerce/POS card with grid, list, and pos variants
- **YoDestinationCard** - Travel app card with default, featured, and compact variants
- **YoProfileCard** - Social app card with default, compact, and cover variants
- **YoArticleCard** - Blog/news card with default, horizontal, and featured variants
- **YoBottomNav** - Animated bottom navigation with badge support
- **YoSidebar** - Collapsible sidebar with expanded/collapsed modes
- **YoDrawerFooter** - Footer widget for drawer

### Added - Color Schemes (6 New)
- **`amoledBlack`** - Pure black AMOLED theme for battery saving
- **`midnightBlue`** - Dark professional theme for enterprise apps
- **`carbonDark`** - Sleek carbon theme for modern dashboards
- **`neonCyberpunk`** - Futuristic neon theme for gaming/tech apps
- **`minimalMono`** - Ultra minimal monochrome theme for focus apps
- **`posRetail`** - Business POS system theme

### Added - Features
- **YoAdaptive** - Comprehensive adaptive design system with breakpoints
- **YoTextTheme.setFont()** - Type-safe font selection using `YoFonts` enum
- **YoFonts enum** - 51 pre-configured Google Fonts for easy selection
- **YoTimeline.stepper()** - Stepper-style timeline factory
- **YoDropDown** - Improved with label, error/helper text, outlined/filled variants
- **Stock indicator** for YoProductCard (for POS systems)
- **Edit/Delete actions** for YoProductCard
- **Dark mode backgrounds** - Changed to pure/near black (#000000) for AMOLED displays

### Improved
- **YoCalendar** - Simplified from 927 to ~420 lines, removed YoCalendarTheme
- **YoKanbanBoard** - Added didUpdateWidget sync, removed duplicate YoKanbanBoardSimple
- **YoComment** - Simplified from 805 to ~280 lines
- **YoChatBubble** - Cleaner code with switch expressions
- **YoDrawer** - Added divider/header items, SafeArea wrapper
- **YoTimeline** - Added isCompleted/isActive states, alternating layout
- **YoEmptyState** - Merged YoErrorState functionality
- **YoDialog** - Simplified with static methods (info, success, error, warning)
- **YoConfirmDialog** - Added showDestructive, showWithIcon methods
- **YoBottomSheet** - Added showList helper, fixed Expanded error
- **YoSnackBar** - Added shortcut methods (success, error, warning, info)
- **YoAvatar** - Added border support, simplified with static maps
- **YoChip** - Added preset variants (success, error, warning, info)

### Fixed
- Replaced all deprecated `withOpacity()` with `withAlpha()`
- Replaced deprecated `textScaleFactor` with `textScaler.scale()`
- Fixed doc comments with unintended HTML (`<T>` → `` `T` ``)
- Fixed recursive build issues in dialogs
- Removed duplicate responsive code (consolidated to YoAdaptive)
- Fixed `YoDeviceHelper` screen size checks

### Deprecated
- `YoResponsive` - Use `YoAdaptive` instead
- Old responsive extensions in `context_extension.dart` and `device_extensions.dart`
- `YoTextTheme.setFontFamily()` - Use `YoTextTheme.setFont()` with `YoFonts` enum instead

### Dependencies
- Added `fl_chart: ^0.69.2` for chart components

---

## [1.0.3+1] - 2025-12-07

### Fixed
- Fixed `onBackground` getter in `YoCorePalette` - now correctly uses `background.computeLuminance()` instead of `primary.computeLuminance()`

## [1.0.3] - 2025-12-01

### Added
- 30 industry-specific color schemes with light/dark mode support
- Comprehensive component library with 60+ widgets
- Responsive design utilities (`YoResponsive`)
- Form components with validation support
- Picker components (Date, Time, DateTime)
- Skeleton loading components
- Kanban board widget
- Timeline widget
- Chat bubble component

### Changed
- Updated to Material 3 design system
- Improved theme customization options

## [1.0.2] - 2025-11-15

### Added
- `YoConnectivity` for network state management
- `YoLogger` for development debugging
- `YoIdGenerator` for various ID generation patterns
- `YoDateFormatter` with relative time support
- `YoCurrencyFormatter` for Indonesian Rupiah

### Improved
- Button variants (primary, secondary, outline, ghost, neumorphism)
- Card elevation options
- Image caching with `cached_network_image`

## [1.0.1] - 2025-10-20

### Added
- Context extensions for easy access to theme styles
- `YoPadding` and `YoSpacing` utility classes
- `YoShadow` for consistent elevation styles
- `YoEmptyState` and `YoErrorState` feedback widgets

### Fixed
- Theme color consistency across components

## [1.0.0] - 2025-10-01

### Added
- Initial release
- Core components (YoText, YoButton, YoCard)
- Theme system with light & dark mode
- Color palette system with `YoColors`
- Typography system with `YoTextTheme`
- Basic layout components (YoColumn, YoRow, YoGrid)
- Navigation components (YoAppBar, YoBottomBar, YoDrawer, YoTabBar)
- Feedback components (YoLoading, YoDialog, YoBottomSheet, YoSnackbar)
- Image handling (YoImage, YoImageViewer)
- Device helper utilities
