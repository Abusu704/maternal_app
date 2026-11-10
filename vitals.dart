// lib/models/vitals.dart
import 'package:hive/hive.dart';

part 'vitals.g.dart';

@HiveType(typeId: 1) // Using typeId: 1 to avoid conflicting with our Appointment model (typeId: 0)
class Vitals extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final DateTime date;

  @HiveField(2)
  final int systolicBP;

  @HiveField(3)
  final int diastolicBP;

  @HiveField(4)
  final double weight;

  Vitals({
    required this.id,
    required this.date,
    required this.systolicBP,
    required this.diastolicBP,
    required this.weight,
  });
}