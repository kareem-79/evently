import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  static Future<UserCredential> register(String email, String password) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return userCredential;
  }

  static Future<void> login(String email, String password) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  static Future<void> addUserToFirestore(UserModel user) {
    FirebaseFirestore dp = FirebaseFirestore.instance;
    CollectionReference<Map<String, dynamic>> userCollection = dp.collection(
      "Users",
    );
    DocumentReference<Map<String, dynamic>> userDocument = userCollection.doc(
      user.id,
    );
    return userDocument.set({
      "id": user.id,
      "name": user.name,
      "email": user.email,
    });
  }
}
