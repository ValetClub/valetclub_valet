import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Otp {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static String verifyId = "";

  static Future<bool> checkPhoneNumberExists(String phoneNumber) async {
    try {
      // Query Firestore to check if the phone number exists
      var querySnapshot = await _firestore
          .collection('users')
          .where('phoneNumber', isEqualTo: phoneNumber)
          .get();

      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      print('Error checking phone number: $e');
      return false;
    }
  }

  // to send an OTP to the user
  static Future<void> sentOtp({
    required String phone,
    required Function errorStep,
    required Function nextStep,
  }) async {
    try {
      await _firebaseAuth.verifyPhoneNumber(
        timeout: const Duration(seconds: 30),
        phoneNumber: "+212$phone",
        verificationCompleted: (phoneAuthCredential) async {
          return;
        },
        verificationFailed: (error) async {
          return;
        },
        codeSent: (verificationId, forceResendingToken) async {
          verifyId = verificationId;
          nextStep();
        },
        codeAutoRetrievalTimeout: (verificationId) async {
          return;
        },
      );
    } catch (e) {
      errorStep(e.toString());
    }
  }

  // Verify the OTP code and login
  static Future<String> loginWithOtp({required String otp}) async {
    final cred =
        PhoneAuthProvider.credential(verificationId: verifyId, smsCode: otp);

    try {
      final user = await _firebaseAuth.signInWithCredential(cred);
      if (user.user != null) {
        return "Success";
      } else {
        return "Error in Otp login";
      }
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    } catch (e) {
      return e.toString();
    }
  }

  // Logout the user
  static Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

  // Check whether the user is logged in or not
  static Future<bool> isLoggedIn() async {
    var user = _firebaseAuth.currentUser;
    return user != null;
  }
}
