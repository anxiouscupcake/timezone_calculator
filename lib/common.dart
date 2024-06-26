import 'package:timezone/timezone.dart' as tz;

String tzOffsetInHours(int milliseconds) {
  int hours = milliseconds ~/ 3600000;
  if (hours < 0) {
    return hours.toString();
  } else {
    return "+${hours.toString()}";
  }
}

String getTzAbbreviationWithHours(tz.Location location) {
  String abbreviation = location.currentTimeZone.abbreviation.toString();
  if (abbreviation[0] == "+" || abbreviation[0] == "-") {
    return "UTC${abbreviation[0]}${abbreviation.substring(2)}";
  } else {
    return "$abbreviation${tzOffsetInHours(location.currentTimeZone.offset)}";
  }
}
