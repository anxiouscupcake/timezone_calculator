import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class TimezoneCardData {
  TimezoneCardData(this.location);
  TimezoneCardData.withTitle(this.location, this.customTitle);

  final tz.Location location;
  String customTitle = "";
}
