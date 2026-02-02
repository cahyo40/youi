# YoUI Flutter - Vibe Coding Cheatsheet

> 🚀 **Just describe what you want** - AI will pick the right components!

---

## 🎯 Quick Start

```yaml
# pubspec.yaml
dependencies:
  yo_ui:
    git:
      url: https://github.com/cahyo40/youi.git
      ref: main
```

```dart
import 'package:yo_ui/yo_ui.dart';

void main() {
  YoTextTheme.setFont(primary: YoFonts.poppins, secondary: YoFonts.inter, mono: YoFonts.spaceMono);
  runApp(MaterialApp(
    theme: YoTheme.lightTheme(context, YoColorScheme.techPurple),
    darkTheme: YoTheme.darkTheme(context, YoColorScheme.techPurple),
    themeMode: ThemeMode.system,
  ));
}
```

---

## 🎨 Instant Styling (Context Extensions)

### Colors - Just Use `context.`

```dart
context.primaryColor      // Brand color
context.successColor      // ✅ Green
context.warningColor      // ⚠️ Orange  
context.errorColor        // ❌ Red
context.infoColor         // ℹ️ Blue
context.gray500           // 🔘 Gray (50-900 available)
context.cardColor         // Card background
```

### Typography - Always Adaptive

```dart
context.yoHeadlineMedium  // Page titles
context.yoTitleLarge      // Section headers
context.yoBodyMedium      // Content text
context.yoLabelSmall      // Captions
context.yoCurrencyMedium  // Money (mono font)
```

### Responsive - Auto Detect

```dart
context.isMobile          // Phone?
context.isTablet          // Tablet?
context.isDesktop         // Desktop?
context.adaptiveMd        // Spacing (16/20/24)
context.adaptivePagePadding  // Page margins
```

---

## 📦 Component Patterns

### 🔥 Forms (Copy-Paste Ready)

```dart
YoForm(children: [
  YoTextFormField(labelText: 'Email', inputType: YoInputType.email, isRequired: true),
  YoTextFormField(labelText: 'Password', inputType: YoInputType.password, showVisibilityToggle: true),
  YoDropDown<String>(
    labelText: 'Category',
    value: selected,
    items: [YoDropDownItem(value: 'a', label: 'Option A')],
    onChanged: (v) => setState(() => selected = v),
  ),
  YoButton(text: 'Submit', onPressed: submit),
])
```

### 🛒 Product Grid

```dart
YoGrid.responsive(
  context: context,
  phoneColumns: 2, tabletColumns: 3, desktopColumns: 4,
  children: products.map((p) => YoProductCard.grid(
    imageUrl: p.image, title: p.name, price: p.price, rating: p.rating,
    onAddToCart: () => addToCart(p),
  )).toList(),
)
```

### 💬 Feedback

```dart
YoToast.success(context, 'Saved!');
YoToast.error(context, 'Failed');
YoDialog.confirm(context, title: 'Delete?', onConfirm: () => delete());
YoLoadingOverlay(isLoading: loading, child: content);
YoSkeletonCard(hasImage: true, hasTitle: true);
```

### 📊 Data Display

```dart
YoDataTable(columns: [...], rows: [...], selectable: true);
YoLineChart(title: 'Revenue', dataSets: [...], curved: true);
YoPieChart.donut(centerText: '75%', data: [...]);
YoTimeline(events: [YoTimelineEvent(title: 'Step 1', isCompleted: true)]);
```

### 🔢 Formatters (Instant Use)

```dart
YoCurrencyFormatter.formatRupiahWithUnit(1500000);  // "Rp 1.5 Juta"
YoDateFormatter.formatRelativeTime(date);           // "5 menit lalu"
YoIdGenerator.orderId();                            // "ORD_20260126847"
```

---

## 🎨 36+ Color Schemes

| Use Case | Scheme |
|----------|--------|
| Tech/SaaS | `YoColorScheme.techPurple` |
| Finance | `YoColorScheme.defaultScheme` |
| E-commerce | `YoColorScheme.retailClay` |
| Healthcare | `YoColorScheme.oceanTeal` |
| Education | `YoColorScheme.educationIndigo` |
| Gaming | `YoColorScheme.gamingNeon` |
| Luxury | `YoColorScheme.luxuryMinimal` |
| Dark Mode | `YoColorScheme.amoledBlack` |

---

## 📁 Sub-Guides

| File | What's Inside |
|------|---------------|
| `COMPONENTS.md` | 80+ UI widgets with examples |
| `THEMES.md` | Colors, fonts, shadows, responsive |
| `HELPERS.md` | Formatters, ID generators, device utils |

---

## ⚡ Vibe Coding Tips

**Just tell AI what you need:**

- "Login form with email and password" → Uses `YoTextFormField` + `YoButton`
- "Product listing with add to cart" → Uses `YoProductCard.grid` + `YoGrid.responsive`
- "Show loading while fetching" → Uses `YoLoadingOverlay` or `YoSkeletonList`
- "Success notification" → Uses `YoToast.success()`
- "Confirm before delete" → Uses `YoDialog.confirm()`

**AI will automatically:**

- Pick the right YoUI component
- Use context extensions for theming
- Apply responsive patterns
- Format data with YoFormatters
