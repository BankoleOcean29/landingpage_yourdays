import 'package:cloud_firestore/cloud_firestore.dart';

class EmailService {
  static Future<bool> saveEmail(String email) async {
    try {
      await FirebaseFirestore.instance.collection('ios_waitlist').add({
        'email': email.trim().toLowerCase(),
        'timestamp': FieldValue.serverTimestamp(),
        'source': 'landing_page_web',
      });
      return true;
    } catch (e) {
      return false;
    }
  }
}
