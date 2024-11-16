class IsDaylightSaving {
  static bool isDaylightSaving(DateTime date) {
    final lastSundayOfMarch = DateTime(date.year, 3, 31)
        .subtract(Duration(days: DateTime(date.year, 3, 31).weekday));
    final lastSundayOfOctober = DateTime(date.year, 10, 31)
        .subtract(Duration(days: DateTime(date.year, 10, 31).weekday));
    return date.isAfter(lastSundayOfMarch) && date.isBefore(lastSundayOfOctober);
  }
}