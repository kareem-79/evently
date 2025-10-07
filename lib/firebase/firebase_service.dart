import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  static Future<UserCredential> register(String email, String password) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return userCredential;
  }

  static Future<UserCredential> login(String email, String password) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return userCredential;
  }

  static CollectionReference<UserModel>getUserCollection() {
    FirebaseFirestore dp = FirebaseFirestore.instance;
    CollectionReference<UserModel> userCollection = dp
        .collection("Users")
        .withConverter<UserModel>(
      fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
      toFirestore: (user, _) => user.toJson(),
    );
    return userCollection;
  }

  static Future<void> addUserToFirestore(UserModel user) {
   CollectionReference<UserModel> userCollection=getUserCollection();
    DocumentReference<UserModel> userDocument = userCollection.doc(user.id);
    return userDocument.set(user);
  }

  static Future<UserModel> getUserFromFireStore(String uid) async {
    CollectionReference<UserModel> userCollection=getUserCollection();
    DocumentReference<UserModel> userDocument = userCollection.doc(uid);
    DocumentSnapshot<UserModel> documentSnapshot = await userDocument.get();
    return documentSnapshot.data()!;
  }
}
