import 'package:json_annotation/json_annotation.dart';

part 'timezone_card_data.g.dart';

@JsonSerializable()
class TimezoneCardData {
  TimezoneCardData(this.location);
  TimezoneCardData.withTitle(this.location, this.customTitle);

  final String location;
  String customTitle = "";

  factory TimezoneCardData.fromJson(Map<String, dynamic> json) =>
      _$TimezoneCardDataFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$TimezoneCardDataToJson(this);

  @override
  bool operator ==(other) =>
      other is TimezoneCardData && other.location == location;

  @override
  int get hashCode => location.hashCode;
}
