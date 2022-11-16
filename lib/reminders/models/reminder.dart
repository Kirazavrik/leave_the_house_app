import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

/// model class
class Reminder extends Equatable{
  /// {@macro reminder}
  Reminder({
    String? id,
    required this.title,
    this.isChecked = false,
}) : assert(
  id == null || id.isNotEmpty,
  'id cannot be null and should be empty',
  ),
  id = id ?? const Uuid().v4();

  /// id
  final String id;

  /// title
  final String title;

  /// checker
  final bool isChecked;

  @override
  List<Object?> get props => [id, title, isChecked];

  /// Return a copy of this reminder
  Reminder copyWith({
    String? id,
    String? title,
    bool? isChecked,
  }) {
    return Reminder(
      id: id ?? this.id,
      title: title ?? this.title,
      isChecked: isChecked ?? this.isChecked,
    );
  }
}
