import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

class TimeOfDayConverter extends JsonConverter<TimeOfDay, String> {
  const TimeOfDayConverter();

  @override
  TimeOfDay fromJson(String json) {
    TimeOfDay timeOfDay = TimeOfDay(
        hour: int.parse(json.split(":")[0]),
        minute: int.parse(json.split(":")[1]));
    return timeOfDay;
  }

  @override
  String toJson(TimeOfDay object) {
    String time = "${object.hour}:${object.minute}";
    return time;
  }
}
