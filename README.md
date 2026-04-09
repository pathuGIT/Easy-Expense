# Easy Expense (expense_planer)

A simple Flutter expense-tracker app that lets you add, edit, delete, and filter expenses.  
Data is stored locally using **Hive**, and the app shows an **expense breakdown pie chart** by category.

## Features
- Add new expenses (title, amount, date, category)
- Edit existing expenses
- Delete expenses (with undo via SnackBar)
- Search expenses by title
- Filter expenses by **date**
- Filter expenses by **category**
- Pie chart breakdown of spending by category (Food / Travel / Leisure / Work)
- Local offline storage using Hive

## Tech Stack
- **Flutter / Dart**
- **Hive** + **hive_flutter** (local database)
- **intl** (date formatting)
- **uuid** (unique IDs)
- **pie_chart** (category breakdown chart)

## Categories
The app currently uses these categories:
- `food`
- `travel`
- `leasure` (note: spelled “leasure” in code)
- `work`
- `all` (for filtering)

## Getting Started

### Prerequisites
- Flutter SDK installed
- Dart SDK (comes with Flutter)

### Install & Run
```bash
git clone https://github.com/pathuGIT/Easy-Expense.git
cd Easy-Expense
flutter pub get
flutter run
```

## Project Structure (important files)
- `lib/main.dart` — app entry point, Hive initialization, opens the `easyExpensedb` box
- `lib/pages/expences.dart` — main screen (pie chart + filters + list)
- `lib/models/expense.dart` — `ExpenseModel` and `Category` enum
- `lib/widgets/` — UI widgets (expense list, tiles, add/edit form, etc.)
- `pubspec.yaml` — dependencies and assets configuration

## Local Storage
The app uses a Hive box named:
- `easyExpensedb`

## Screenshots
<img
      src="https://github.com/user-attachments/assets/11dd558f-eb11-4abc-b2e6-d8326389c9e5"
      width="300"
      alt="Row layout demo 02"
    />
<img
      src="https://github.com/user-attachments/assets/21ae6694-edb0-479e-ac93-56534011f252"
      width="300"
      alt="Row layout demo 02"
    />
<img
      src="https://github.com/user-attachments/assets/a0f5fd46-6b01-4150-be53-bbcb43b9e593"
      width="300"
      alt="Row layout demo 02"
    />
<img
      src="https://github.com/user-attachments/assets/ccab741f-079d-42e9-9a25-15bfd74b9cea"
      width="300"
      alt="Row layout demo 02"
    />
<img
      src="https://github.com/user-attachments/assets/89e1eee2-029b-48fd-ae30-58585415910e"
      width="300"
      alt="Row layout demo 02"
    />


## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you’d like to change.

