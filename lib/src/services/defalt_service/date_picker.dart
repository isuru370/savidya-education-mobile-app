import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simple_month_year_picker/simple_month_year_picker.dart';

DateTime dateTime = DateTime.now();

Future<String?> selectBirthdayDate(BuildContext context) async {
  DateTime? showDatePicker2 = await showDatePicker(
      locale: const Locale('en'),
      context: context,
      initialDate: DateTime(1990),
      firstDate: DateTime(1980),
      lastDate: DateTime.now());

  if (showDatePicker2 != null) {
    String birthdayDate = DateFormat("yyyy-MM-dd").format(showDatePicker2);
    return birthdayDate;
  } else {
    return null;
  }
}

Future<String?> selectYouDate(BuildContext context) async {
  DateTime? showDatePicker2 = await showDatePicker(
      locale: const Locale('en'),
      context: context,
      initialDate: DateTime(1990),
      firstDate: DateTime(1980),
      lastDate: DateTime.now());

  if (showDatePicker2 != null) {
    String birthdayDate = DateFormat("yyyy-MM-dd").format(showDatePicker2);
    return birthdayDate;
  } else {
    return null;
  }
}

Future<String?> selectYearPicker(BuildContext context) async {
  DateTime? showDatePicker2 = await showDialog<DateTime>(
    context: context,
    builder: (BuildContext context) {
      DateTime selectedDate = DateTime.now();
      return AlertDialog(
        content: SizedBox(
          height: 300,
          width: 300,
          child: YearPicker(
            onChanged: (DateTime dateTime) {
              selectedDate = dateTime;
              Navigator.pop(context, selectedDate);
            },
            firstDate: DateTime(DateTime.now().year - 100, 1),
            lastDate: DateTime(2500),
            selectedDate: selectedDate,
          ),
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('cancel'))
        ],
      );
    },
  );

  if (showDatePicker2 != null) {
    String graduationYear = DateFormat("yyyy").format(showDatePicker2);
    return graduationYear;
  } else {
    return null;
  }
}

Future<Map<String, dynamic>> selectClassDate(BuildContext context) async {
  final selectedDate = await SimpleMonthYearPicker.showMonthYearPickerDialog(
    context: context,
    titleTextStyle: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    monthTextStyle: const TextStyle(
      fontSize: 18,
      color: Colors.black54,
    ),
    yearTextStyle: const TextStyle(
      fontSize: 18,
      color: Colors.black54,
    ),
    disableFuture: false, // Disable future dates
  );

  return {
    "select_date": selectedDate,
    "format_date": DateFormat("yyyy-MMM").format(selectedDate),
  };
}

Future<String?> selectFutureDate(BuildContext context) async {
  DateTime? showDatePicker2 = await showDatePicker(
      locale: const Locale('en'),
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100));

  if (showDatePicker2 != null) {
    String birthdayDate = DateFormat("yyyy-MM-dd").format(showDatePicker2);
    return birthdayDate;
  } else {
    return null;
  }
}
