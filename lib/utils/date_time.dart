import 'package:intl/intl.dart';

String formatDate(String isoDate) {
  // Parse the ISO date time string
  final dateTime = DateTime.parse(isoDate);

  // Format the date time to month-year format
  final formattedDate = DateFormat.yMMMM().format(dateTime);

  return formattedDate;
}
