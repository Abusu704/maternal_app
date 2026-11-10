// lib/models/appointment.dart
import 'package:hive/hive.dart';

part 'appointment.g.dart';

@HiveType(typeId: 0)
class Appointment extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final DateTime date;

  @HiveField(3)
  final String doctorName;

  @HiveField(4)
  final String notes;

  Appointment({
    required this.id,
    required this.title,
    required this.date,
    required this.doctorName,
    required this.notes,
  });
}