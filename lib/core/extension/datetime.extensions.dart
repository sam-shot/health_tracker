extension DateTimeExtensions on DateTime {
  String get formattedDate {
    final dayNames = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final monthNames = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    String getOrdinal(int day) {
      if (day >= 11 && day <= 13) return '${day}th';
      switch (day % 10) {
        case 1:
          return '${day}st';
        case 2:
          return '${day}nd';
        case 3:
          return '${day}rd';
        default:
          return '${day}th';
      }
    }

    final dayName = dayNames[weekday - 1];
    final dayWithOrdinal = getOrdinal(day);
    final monthName = monthNames[month - 1];
    final hourFormatted = hour == 0 ? 12 : (hour > 12 ? hour - 12 : hour);
    final period = hour < 12 ? 'AM' : 'PM';
    final minuteFormatted = minute.toString().padLeft(2, '0');

    return '$dayName, $dayWithOrdinal of $monthName $year | ${hourFormatted.toString().padLeft(2, '0')}:$minuteFormatted $period';
  }

  bool isSameDayAs(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}
