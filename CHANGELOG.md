# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.3+1] - 2024-12-07

### Fixed
- Fixed `onBackground` getter in `YoCorePalette` - now correctly uses `background.computeLuminance()` instead of `primary.computeLuminance()`

## [1.0.3] - 2024-12-01

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

## [1.0.2] - 2024-11-15

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

## [1.0.1] - 2024-10-20

### Added
- Context extensions for easy access to theme styles
- `YoPadding` and `YoSpacing` utility classes
- `YoShadow` for consistent elevation styles
- `YoEmptyState` and `YoErrorState` feedback widgets

### Fixed
- Theme color consistency across components

## [1.0.0] - 2024-10-01

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
