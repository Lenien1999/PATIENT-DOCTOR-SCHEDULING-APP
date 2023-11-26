import 'package:flutter/material.dart';

class Doctors {
  String? id;
  String specialist;
  String name;
  String description;
  bool favorite;
  String hospital;
  List<WorkingHour> workingHours;
  int? experience;
  String aboutMe;
  String image;

  Doctors({
    this.id,
    required this.workingHours,
    required this.aboutMe,
    this.experience,
    required this.hospital,
    required this.image,
    required this.specialist,
    required this.name,
    required this.description,
    this.favorite = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'id':id,
      'specialist': specialist,
      'name': name,
      'description': description,
      'favorite': favorite,
      'hospital': hospital,
      'workingHours': workingHours.map((wh) => wh.toJson()).toList(),
      'experience': experience,
      'aboutMe': aboutMe,
      'image': image,
    };
  }

  factory Doctors.fromJson(Map<String, dynamic> data, String id) {
    List<dynamic> workingHoursData = data['workingHours'] ?? [];
    List<WorkingHour> workingHours =
        workingHoursData.map((whData) => WorkingHour.fromJson(whData)).toList();
    return Doctors(
      specialist: data['specialist'] ?? '',
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      favorite: data['favorite'] ?? false,
      hospital: data['hospital'] ?? '',
      workingHours: workingHours,
      experience: data['experience'],
      aboutMe: data['aboutMe'] ?? '',
      image: data['image'] ?? '',
    );
  }
}

class WorkingHour {
  TimeOfDay startTime;
  TimeOfDay endTime;

  WorkingHour({
    required this.startTime,
    required this.endTime,
  });

  Map<String, dynamic> toJson() {
    return {
      'startTime': _convertTimeOfDayToString(startTime),
      'endTime': _convertTimeOfDayToString(endTime),
    };
  }

  factory WorkingHour.fromJson(Map<String, dynamic> data) {
    return WorkingHour(
      startTime: _convertStringToTimeOfDay(data['startTime'] ?? ''),
      endTime: _convertStringToTimeOfDay(data['endTime'] ?? ''),
    );
  }

  static TimeOfDay _convertStringToTimeOfDay(String timeString) {
    final parts = timeString.split(':');
    return TimeOfDay(
      hour: int.parse(parts[0]),
      minute: int.parse(parts[1]),
    );
  }

  static String _convertTimeOfDayToString(TimeOfDay time) {
    final hours = time.hour.toString().padLeft(2, '0');
    final minutes = time.minute.toString().padLeft(2, '0');
    return '$hours:$minutes';
  }
}

class DoctorCategory {
  String specialist;
  List<Doctors> doctors;
  DoctorCategory({required this.specialist, required this.doctors});
}

List<Doctors> doctorList = [
  Doctors(
    workingHours: [
      WorkingHour(
          startTime: const TimeOfDay(hour: 9, minute: 30),
          endTime: const TimeOfDay(hour: 10, minute: 30)),
      WorkingHour(
          startTime: const TimeOfDay(hour: 10, minute: 30),
          endTime: const TimeOfDay(hour: 12, minute: 0)),
      WorkingHour(
          startTime: const TimeOfDay(hour: 13, minute: 0),
          endTime: const TimeOfDay(hour: 14, minute: 0)),
      WorkingHour(
          startTime: const TimeOfDay(hour: 14, minute: 0),
          endTime: const TimeOfDay(hour: 15, minute: 0)),
      WorkingHour(
          startTime: const TimeOfDay(hour: 14, minute: 0),
          endTime: const TimeOfDay(hour: 15, minute: 0)),
      WorkingHour(
          startTime: const TimeOfDay(hour: 15, minute: 0),
          endTime: const TimeOfDay(hour: 15, minute: 30)),
    ],
    experience: 3,
    hospital: 'Maternity Center, Ipapo',
    aboutMe:
        'Dr. Jenny Watson is the top most Immunologists specialist in Christ Hospital at London. She achived several awards for her wonderful contribution in medical field. She is available for private consultation.',
    name: 'Dr Lenient',
    description:
        'Jorem ipsum dolor, consectetur adipiscing elit. Nunc v libero et velit interdum, ac  mattis.',
    specialist: 'Surgeon',
    image: 'assets/images/DOCTOR1.png',
  ),
  Doctors(
      workingHours: [
        WorkingHour(
            startTime: const TimeOfDay(hour: 9, minute: 30),
            endTime: const TimeOfDay(hour: 10, minute: 30)),
        WorkingHour(
            startTime: const TimeOfDay(hour: 10, minute: 30),
            endTime: const TimeOfDay(hour: 12, minute: 0)),
        WorkingHour(
            startTime: const TimeOfDay(hour: 13, minute: 0),
            endTime: const TimeOfDay(hour: 14, minute: 0)),
        WorkingHour(
            startTime: const TimeOfDay(hour: 14, minute: 0),
            endTime: const TimeOfDay(hour: 15, minute: 0)),
        WorkingHour(
            startTime: const TimeOfDay(hour: 14, minute: 0),
            endTime: const TimeOfDay(hour: 15, minute: 0)),
        WorkingHour(
            startTime: const TimeOfDay(hour: 15, minute: 0),
            endTime: const TimeOfDay(hour: 15, minute: 30)),
      ],
      experience: 7,
      hospital: 'General Hospital, Ibadan',
      aboutMe:
          'Dr. Aminullah Watson is the top most Nutrition specialist in General Hospital at London. She achived several awards for her wonderful contribution in medical field. He is available for private consultation.',
      name: 'Dr Aminullah',
      description:
          'Jorem ipsum dolor, consectetur adipiscing elit. Nunc v libero et velit interdum, ac  mattis.',
      specialist: 'Nutrition',
      image: 'assets/images/dr1.png'),
  Doctors(
      workingHours: [
        WorkingHour(
            startTime: const TimeOfDay(hour: 9, minute: 30),
            endTime: const TimeOfDay(hour: 10, minute: 30)),
        WorkingHour(
            startTime: const TimeOfDay(hour: 10, minute: 30),
            endTime: const TimeOfDay(hour: 12, minute: 0)),
        WorkingHour(
            startTime: const TimeOfDay(hour: 13, minute: 0),
            endTime: const TimeOfDay(hour: 14, minute: 0)),
        WorkingHour(
            startTime: const TimeOfDay(hour: 14, minute: 0),
            endTime: const TimeOfDay(hour: 15, minute: 0)),
        WorkingHour(
            startTime: const TimeOfDay(hour: 14, minute: 0),
            endTime: const TimeOfDay(hour: 15, minute: 0)),
        WorkingHour(
            startTime: const TimeOfDay(hour: 15, minute: 0),
            endTime: const TimeOfDay(hour: 15, minute: 30)),
      ],
      experience: 5,
      hospital: 'D crescent Hospital',
      aboutMe:
          'Dr. Aminullah is the top most Radiologist specialist inD crescent Hospital. She achived several awards for her wonderful contribution in medical field. He is available for private consultation.',
      name: 'Dr Ayansola',
      description:
          'Jorem ipsum dolor, consectetur adipiscing elit. Nunc v libero et velit interdum, ac  mattis.',
      specialist: 'Radiologist',
      image: 'assets/images/doctor2.png'),
  Doctors(
      workingHours: [
        WorkingHour(
            startTime: const TimeOfDay(hour: 9, minute: 30),
            endTime: const TimeOfDay(hour: 10, minute: 30)),
        WorkingHour(
            startTime: const TimeOfDay(hour: 10, minute: 30),
            endTime: const TimeOfDay(hour: 12, minute: 0)),
        WorkingHour(
            startTime: const TimeOfDay(hour: 13, minute: 0),
            endTime: const TimeOfDay(hour: 14, minute: 0)),
        WorkingHour(
            startTime: const TimeOfDay(hour: 14, minute: 0),
            endTime: const TimeOfDay(hour: 15, minute: 0)),
        WorkingHour(
            startTime: const TimeOfDay(hour: 14, minute: 0),
            endTime: const TimeOfDay(hour: 15, minute: 0)),
        WorkingHour(
            startTime: const TimeOfDay(hour: 15, minute: 0),
            endTime: const TimeOfDay(hour: 15, minute: 30)),
      ],
      experience: 6,
      hospital: 'D Manuscript Hospital',
      aboutMe:
          'Dr. Ayanwale is the top most Dentist specialist in D Manuscript Hospital. She achived several awards for her wonderful contribution in medical field. He is available for private consultation.',
      name: 'Dr Ayanwale',
      description:
          'Jorem ipsum dolor, consectetur adipiscing elit. Nunc v libero et velit interdum, ac  mattis.',
      specialist: 'Dentist',
      image: 'assets/images/doctor6.png'),
  Doctors(
      workingHours: [
        WorkingHour(
            startTime: const TimeOfDay(hour: 9, minute: 30),
            endTime: const TimeOfDay(hour: 10, minute: 30)),
        WorkingHour(
            startTime: const TimeOfDay(hour: 10, minute: 30),
            endTime: const TimeOfDay(hour: 12, minute: 0)),
        WorkingHour(
            startTime: const TimeOfDay(hour: 13, minute: 0),
            endTime: const TimeOfDay(hour: 14, minute: 0)),
        WorkingHour(
            startTime: const TimeOfDay(hour: 14, minute: 0),
            endTime: const TimeOfDay(hour: 15, minute: 0)),
        WorkingHour(
            startTime: const TimeOfDay(hour: 14, minute: 0),
            endTime: const TimeOfDay(hour: 15, minute: 0)),
        WorkingHour(
            startTime: const TimeOfDay(hour: 15, minute: 0),
            endTime: const TimeOfDay(hour: 15, minute: 30)),
      ],
      experience: 6,
      hospital: 'D James Hospital',
      aboutMe:
          'Dr. Olamilekan is the top most Dentist specialist in D James Hospital. She achived several awards for her wonderful contribution in medical field. He is available for private consultation.',
      name: 'Dr Olamilekan',
      description:
          'Jorem ipsum dolor, consectetur adipiscing elit. Nunc v libero et velit interdum, ac  mattis.',
      specialist: 'Surgeon',
      image: 'assets/images/dorctor3.png'),
  Doctors(
      workingHours: [
        WorkingHour(
            startTime: const TimeOfDay(hour: 9, minute: 30),
            endTime: const TimeOfDay(hour: 10, minute: 30)),
        WorkingHour(
            startTime: const TimeOfDay(hour: 10, minute: 30),
            endTime: const TimeOfDay(hour: 12, minute: 0)),
        WorkingHour(
            startTime: const TimeOfDay(hour: 13, minute: 0),
            endTime: const TimeOfDay(hour: 14, minute: 0)),
        WorkingHour(
            startTime: const TimeOfDay(hour: 14, minute: 0),
            endTime: const TimeOfDay(hour: 15, minute: 0)),
        WorkingHour(
            startTime: const TimeOfDay(hour: 14, minute: 0),
            endTime: const TimeOfDay(hour: 15, minute: 0)),
        WorkingHour(
            startTime: const TimeOfDay(hour: 15, minute: 0),
            endTime: const TimeOfDay(hour: 15, minute: 30)),
      ],
      experience: 6,
      hospital: 'D Manuscript Hospital',
      aboutMe:
          'Dr. Ayanwale is the top most Dentist specialist in D Manuscript Hospital. She achived several awards for her wonderful contribution in medical field. He is available for private consultation.',
      name: 'Dr Joseph',
      description:
          'Jorem ipsum dolor, consectetur adipiscing elit. Nunc v libero et velit interdum, ac  mattis.',
      specialist: 'Radiologist',
      image: 'assets/images/dr.png'),
];

List<DoctorCategory> doctorCartegoryList = [
  DoctorCategory(specialist: 'Dentist', doctors: doctorList),
  DoctorCategory(specialist: 'Nutrition', doctors: doctorList),
  DoctorCategory(specialist: 'Surgeon', doctors: doctorList),
  DoctorCategory(specialist: 'Radiologist', doctors: doctorList),
];
