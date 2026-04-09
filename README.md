# Easy Expense 💸

A cross-platform personal expense tracker built with Flutter. Easily add, edit, and delete expenses across categories, visualize your spending with a pie chart, and filter or search your history — all stored locally on your device.

---

## Features

- **Add / Edit / Delete expenses** — manage each expense with a title, amount, date, and category
- **Undo delete** — restore a deleted expense via the snackbar undo action
- **Pie chart** — visual breakdown of spending by category (Food, Travel, Leisure, Work)
- **Search** — filter expenses by title in real time
- **Date filter** — pick a date to view expenses for that day
- **Category filter** — narrow the list to a specific category
- **Local persistence** — all data is stored on-device with [Hive](https://pub.dev/packages/hive); no account or internet required
- **Multi-platform** — runs on Android, iOS, Web, Linux, macOS, and Windows

---

## Screenshots

> _Add screenshots here once the app is built._

---

## Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) **≥ 3.10.7**
- Dart SDK bundled with Flutter

### Installation

```bash
# 1. Clone the repository
git clone https://github.com/pathuGIT/Easy-Expense.git
cd Easy-Expense

# 2. Install dependencies
flutter pub get

# 3. Run the app
flutter run
```

### Build

```bash
# Android APK
flutter build apk --release

# iOS (macOS required)
flutter build ios --release

# Web
flutter build web --release
```

---

## Project Structure

```
lib/
├── main.dart               # App entry point; Hive initialisation
├── models/
│   ├── expense.dart        # ExpenseModel & Category enum (Hive type)
│   └── expense.g.dart      # Generated Hive type adapter
├── pages/
│   └── expences.dart       # Main screen with pie chart, filters, and expense list
├── widgets/
│   ├── expense_list.dart   # Scrollable list of expense tiles
│   ├── expense_tile.dart   # Single expense row with swipe-to-delete
│   ├── new_expense.dart    # Bottom-sheet form for adding / editing an expense
│   └── show_wallet_page.dart
└── server/
    ├── database.dart       # Hive read/write helpers
    └── category_adapter.dart
```

---

## Dependencies

| Package | Purpose |
|---|---|
| [hive](https://pub.dev/packages/hive) + [hive_flutter](https://pub.dev/packages/hive_flutter) | Local NoSQL storage |
| [pie_chart](https://pub.dev/packages/pie_chart) | Expense breakdown chart |
| [intl](https://pub.dev/packages/intl) | Date formatting |
| [uuid](https://pub.dev/packages/uuid) | Unique expense IDs |
| [cupertino_icons](https://pub.dev/packages/cupertino_icons) | iOS-style icons |

---

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

---

## License

This project is open source. See the [LICENSE](LICENSE) file for details.

