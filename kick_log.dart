// lib/models/kick_log.dart
import 'package:hive/hive.dart';

part 'kick_log.g.dart';

@HiveType(typeId: 2) // Using typeId: 2 to avoid conflicts with previous models
class KickLog extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final DateTime date;

  @HiveField(2)
  final int count;

  @HiveField(3)
  final int durationInMinutes;

  KickLog({
    required this.id,
    required this.date,
    required this.count,
    required this.durationInMinutes,
  });
}