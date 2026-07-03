import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  //=========================
  // FIRESTORE -> MAP
  //=========================
  Map<String, dynamic> toMap() {
    return {
      "heartRate": heartRate,
      "systolic": systolic,
      "diastolic": diastolic,
      "temperature": temperature,
      "weight": weight,
      "steps": steps,
      "date": date,
      "notes": notes,
      "createdAt": Timestamp.now(), // tambahkan ini
    };
  }

  //=========================
  // MAP -> OBJECT
  //=========================
  factory HealthData.fromMap(Map<String, dynamic> map) {
    return HealthData(
      heartRate: map["heartRate"] ?? "",
      systolic: map["systolic"] ?? "",
      diastolic: map["diastolic"] ?? "",
      temperature: map["temperature"] ?? "",
      weight: map["weight"] ?? "",
      steps: map["steps"] ?? "",
      date: map["date"] ?? "",
      notes: map["notes"] ?? "",
    );
  }
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
