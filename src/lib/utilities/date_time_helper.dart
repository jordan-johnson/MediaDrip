class DateTimeHelper {
  static bool isToday(DateTime dateTime) {
    var now = DateTime.now();

    return dateTime == DateTime(now.year, now.month, now.day);
  }

  static bool isYesterday(DateTime dateTime) {
    var now = DateTime.now();

    return dateTime == DateTime(now.year, now.month, now.day - 1);
  }

  static bool isWithinDaysFromNow(DateTime dateTime, int start, int end) {
    var now = DateTime.now();
    var before = now.subtract(Duration(days: start));
    var after = now.subtract(Duration(days: end));

    return dateTime.isBefore(before) && dateTime.isAfter(after);
  }

  static DateTime unixToDateTime(double timestamp) {
    var update = timestamp.round() * 1000;

    return DateTime.fromMillisecondsSinceEpoch(update, isUtc: true).toLocal();
  }
}