import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServices {
  Future<void> createUserData(String uid, String name, String email) async {
    // Implementation for creating user data in the database
  }

  Future<void> updateUserData(String uid, Map<String, dynamic> data) async {
    // Implementation for updating user data in the database
  }

  Future<Map<String, dynamic>?> getUserData(String uid) async {
    // Implementation for retrieving user data from the database
    return null;
  }

  Future<void> deleteUserData(String uid) async {
    // Implementation for deleting user data from the database
  }

  Future<List<Map<String, dynamic>>> getAllUsers() async {
    // Implementation for retrieving all users from the database
    return [];
  }

  Future addAppointment(Map<String, dynamic> appointment) async {
    return await FirebaseFirestore.instance
        .collection("appointments")
        .add(appointment);
  }

  Future addUserDetails(Map<String, dynamic> userInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .set(userInfoMap);
  }
}
