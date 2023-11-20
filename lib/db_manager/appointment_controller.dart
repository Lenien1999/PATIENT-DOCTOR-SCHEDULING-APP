import 'package:cloud_firestore/cloud_firestore.dart';

import '../controller/model/appointment_controller/booking_model.dart';

class BookingController {
  final CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection('appointment');

  Future<void> bookAppointment(Bookings bookings) async {
    await _collectionReference.add(bookings.toJson());
  }

  Stream<List<Bookings>> appointmentList() {
    return _collectionReference.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        final id = doc.id; // Fetching the document ID
        return Bookings.fromJson(
            data, id); // Pass the ID to the fromJson method
      }).toList();
    });
  }

  Future<void> markTaskAsComplete(Bookings book) async {
    _collectionReference.doc(book.id).update({
      "isComplete": book.isComplete,
      "cancellationTimestamp": book.isComplete
          ? DateTime.now() // Set cancellation timestamp only when canceled
          : null, // Clear cancellation timestamp if not canceled});
    });
  }



  Future<void> markTaskAsCancelled(Bookings book) async {
    _collectionReference.doc(book.id).update({
      "isCancelled": book.isCancelled,
      "cancellationTimestamp": book.isCancelled
          ? DateTime.now() // Set cancellation timestamp only when canceled
          : null, // Clear cancellation timestamp if not canceled});
    });
  }

  Stream<List<Bookings>> cancelappointmentList() {
    return _collectionReference
        .where('isCancelled', isEqualTo: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        final id = doc.id; // Fetching the document ID
        return Bookings.fromJson(
            data, id); // Pass the ID to the fromJson method
      }).toList();
    });
  }

  Stream<List<Bookings>> completeappointmentList() {
    return _collectionReference
        .where('isComplete', isEqualTo: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        final id = doc.id; // Fetching the document ID
        return Bookings.fromJson(
            data, id); // Pass the ID to the fromJson method
      }).toList();
    });
  }
}
