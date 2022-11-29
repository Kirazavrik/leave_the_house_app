part of 'notification_cubit.dart';

enum NotificationStatus { initial, timeChanged, failure }

@JsonSerializable()
@TimeOfDayConverter()
class NotificationState extends Equatable {
  NotificationState({
    this.status = NotificationStatus.initial,
    this.isEnabled = false,
    TimeOfDay? time,
}) : time = time ?? TimeOfDay(hour: 8, minute: 50);

  final NotificationStatus status;
  final TimeOfDay time;
  final bool isEnabled;

  NotificationState copyWith({
    NotificationStatus? status,
    TimeOfDay? time,
    bool? isEnabled,
  }) {
    return NotificationState(
      status: status ?? this.status,
      time: time ?? this.time,
      isEnabled: isEnabled ?? this.isEnabled,
    );
  }

  @override
  List<Object> get props => [status, time, isEnabled];

  Map<String, dynamic> toJson() => _$NotificationStateToJson(this);
  factory NotificationState.fromJson(Map<String, dynamic> json) => _$NotificationStateFromJson(json);

}
