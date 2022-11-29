// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationState _$NotificationStateFromJson(Map<String, dynamic> json) =>
    NotificationState(
      status:
          $enumDecodeNullable(_$NotificationStatusEnumMap, json['status']) ??
              NotificationStatus.initial,
      isEnabled: json['isEnabled'] as bool? ?? false,
      time: _$JsonConverterFromJson<String, TimeOfDay>(
          json['time'], const TimeOfDayConverter().fromJson),
    );

Map<String, dynamic> _$NotificationStateToJson(NotificationState instance) =>
    <String, dynamic>{
      'status': _$NotificationStatusEnumMap[instance.status]!,
      'time': const TimeOfDayConverter().toJson(instance.time),
      'isEnabled': instance.isEnabled,
    };

const _$NotificationStatusEnumMap = {
  NotificationStatus.initial: 'initial',
  NotificationStatus.timeChanged: 'timeChanged',
  NotificationStatus.failure: 'failure',
};

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);
