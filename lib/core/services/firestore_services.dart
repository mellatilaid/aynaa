import 'package:atm_app/const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirestoreServices {
  final _firestore = FirebaseFirestore.instance;
  Future<String> getUserRole({required UserCredential userCredential}) async {
    DocumentSnapshot userDoc = await _firestore
        .collection(kUsersCol)
        .doc(userCredential.user!.uid)
        .get();
    if (!userDoc.exists) {
      return kStudentRole;
    }

    final String userRole = userDoc.exists ? userDoc[kUserRole] : kStudentRole;
    return userRole;
  }

  Future<void> addUser({required UserCredential userCredential}) async {
    await _firestore.collection(kUsersCol).doc(userCredential.user!.uid).set({
      kUserEmail: userCredential.user!.email,
      kUserName: userCredential.user!.displayName,
      kUserRole: kStudentRole,
    });
  }

  Future<bool> doesUserExist({required String? uid}) async {
    final DocumentSnapshot userDoc =
        await _firestore.collection(kUsersCol).doc(uid).get();
    return userDoc.exists;
  }
}
