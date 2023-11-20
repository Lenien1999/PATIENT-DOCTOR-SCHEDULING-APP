import 'package:cloud_firestore/cloud_firestore.dart';

import '../auth/auth_controller/auth_model.dart';

class FirebaseMethods {
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  Future<void> addUserData(UserModel user) async {
    return await usersCollection.doc(user.id).set(user.toJson());
  }

  Stream<UserModel?> userStream(String userId) {
    return usersCollection.doc(userId).snapshots().map((snapshot) {
      if (snapshot.exists) {
        return UserModel.fromJson(snapshot.data() as Map<String, dynamic>);
      } else {
        return null;
      }
    });
  }

  Future<UserModel?> getUserData(String userId) async {
    try {
      var snapshot = await usersCollection.doc(userId).get();

      if (snapshot.exists) {
        return UserModel.fromJson(snapshot.data() as Map<String, dynamic>);
      } else {
        return null;
      }
    } catch (e) {
      // Handle exceptions or errors
      print('Error fetching user data: $e');
      return null;
    }
  }
}
