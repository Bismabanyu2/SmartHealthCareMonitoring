import 'package:flutter/material.dart';

class HealthData {
  final String heartRate;
  final String systolic;
  final String diastolic;
  final String temperature;
  final String weight;
  final String steps;
  final String date;
  final String notes;

  HealthData({
    required this.heartRate,
    required this.systolic,
    required this.diastolic,
    required this.temperature,
    required this.weight,
    required this.steps,
    required this.date,
    this.notes = '',
  });
}

class Medicine {
  final String name;
  final String dosage;
  final String time;
  final bool taken;
  final Color color;

  Medicine({
    required this.name,
    required this.dosage,
    required this.time,
    this.taken = false,
    required this.color,
  });
}
