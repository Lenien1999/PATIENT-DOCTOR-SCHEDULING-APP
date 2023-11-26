import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../doctor_controller.dart/doctor_model.dart';

class Bookings {
  String? id;
  String userId;
  String name;
  String gender;
  String age;
  bool isComplete;
  bool isCancelled;
  String problems;
  Doctors doctor;
  DateTime date;
  TimeOfDay startTime;
  DateTime? cancellationTimestamp;
  TimeOfDay endTime;
  Bookings({
    this.isCancelled = false,
    this.isComplete = false,
    this.id,
    required this.doctor,
    required this.userId,
    this.cancellationTimestamp,
    required this.age,
    required this.date,
    required this.gender,
    required this.name,
    required this.endTime,
    required this.startTime,
    required this.problems,
  });
  String getFormattedStartTime() {
    return '${startTime.hour}:${startTime.minute}';
  }

  String getFormattedEndTime() {
    return '${endTime.hour}:${endTime.minute}';
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'age': age,
      'date': date,
      'gender': gender,
      'name': name,
      'problems': problems,
      'startTime': getFormattedStartTime(),
      'endTime': getFormattedEndTime(),
      'doctor': doctor.toJson(),
      'isCancelled': isCancelled,
      'cancellationTimestamp': cancellationTimestamp,
      'isComplete': isComplete,
    };
  }

  factory Bookings.fromJson(Map<String, dynamic> data, String id) {
    return Bookings(
      id: id,
      userId: data['userId'] ?? '',
      age: data['age'] ?? '',
      date: (data['date'] as Timestamp?)?.toDate() ?? DateTime.now(),
      gender: data['gender'] ?? '',
      name: data['name'] ?? '',
      problems: data['problems'] ?? '',
      isCancelled: data['isCancelled'] ?? false,
      isComplete: data['isComplete'] ?? false,
      doctor: Doctors.fromJson(data['doctor'] ?? {}, id),
      startTime: _convertStringToTimeOfDay(data['startTime'] ?? ''),
      endTime: _convertStringToTimeOfDay(data['endTime'] ?? ''),
      cancellationTimestamp:
          (data['cancellationTimestamp'] as Timestamp?)?.toDate() ??
              DateTime.now(),
    );
  }
  static TimeOfDay _convertStringToTimeOfDay(String timeString) {
    final parts = timeString.split(':');
    return TimeOfDay(
      hour: int.parse(parts[0]),
      minute: int.parse(parts[1]),
    );
  }
}
