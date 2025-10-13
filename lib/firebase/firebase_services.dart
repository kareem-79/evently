import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/model/category_model.dart';
import 'package:evently/model/event_model.dart';
import 'package:evently/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class FirebaseServices {
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

  static CollectionReference<UserModel> getUserCollection() {
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
    CollectionReference<UserModel> userCollection = getUserCollection();
    DocumentReference<UserModel> userDocument = userCollection.doc(user.id);
    return userDocument.set(user);
  }

  static Future<UserModel?> getUserFromFireStore(String uid) async {
    CollectionReference<UserModel> userCollection = getUserCollection();
    DocumentReference<UserModel> userDocument = userCollection.doc(uid);
    DocumentSnapshot<UserModel> documentSnapshot = await userDocument.get();

    if (!documentSnapshot.exists || documentSnapshot.data() == null) {
      log("⚠️ User not found in Firestore for uid: $uid");
      return null;
    }

    return documentSnapshot.data();
  }

  static CollectionReference<EventModel> getEventCollection(
    BuildContext context,
  ) {
    FirebaseFirestore dp = FirebaseFirestore.instance;
    CollectionReference<EventModel> eventCollection = dp
        .collection("Events")
        .withConverter<EventModel>(
          fromFirestore: (snapshot, _) =>
              EventModel.fromJson(snapshot.data()!, context),
          toFirestore: (event, _) => event.toJson(),
        );
    return eventCollection;
  }

  static Future<void> addEventToFireStore(
    EventModel event,
    BuildContext context,
  ) {
    CollectionReference<EventModel> eventCollection = getEventCollection(
      context,
    );
    DocumentReference<EventModel> eventDocument = eventCollection.doc();
    event.id = eventDocument.id;
    return eventDocument.set(event);
  }

  static Future<List<EventModel>> getEvents(
    BuildContext context,
    CategoryModel? category,
  ) async {
    CollectionReference<EventModel> eventCollection = getEventCollection(
      context,
    );

    var query = eventCollection.orderBy("dateTime", descending: true);

    if (category?.id != "0") {
      query = query.where("categoryId", isEqualTo: category?.id);
    }

    var querySnapshot = await query.get();

    List<EventModel> events = querySnapshot.docs
        .map((docSnapshot) => docSnapshot.data())
        .toList();

    return events;
  }

  static Stream<List<EventModel>> getEventsWithRealTimeUpdates(
    BuildContext context,
    CategoryModel category,
  ) async* {
    CollectionReference<EventModel> eventCollection = getEventCollection(
      context,
    );

    var query = eventCollection.orderBy("dateTime", descending: true);

    if (category.id != "0" && category.id.isNotEmpty) {
      query = query.where("categoryId", isEqualTo: category.id);
    }
    var snapshots = query.snapshots();

    yield* snapshots.map(
      (snapshot) =>
          snapshot.docs.map((docSnapshot) => docSnapshot.data()).toList(),
    );
  }

  static Future<void> addEventToFavorite(EventModel event) async {
    if (UserModel.currentUser == null) return;

    UserModel currentUser = UserModel.currentUser!;

    if (!currentUser.favouriteEventIds.contains(event.id)) {
      currentUser.favouriteEventIds.add(event.id);
      CollectionReference<UserModel> userCollection = getUserCollection();
      DocumentReference<UserModel> userDocument = userCollection.doc(
        currentUser.id,
      );
      await userDocument.update({
        'favouriteEventIds': currentUser.favouriteEventIds,
      });
    }
  }

  static Future<List<EventModel>>getFavouriteEvents(BuildContext context) async {
    CollectionReference<EventModel> eventCollection = getEventCollection(
      context,
    );
    QuerySnapshot<EventModel> querySnapshot = await eventCollection.get();
    List<EventModel> events = querySnapshot.docs
        .map((docSnapshot) => docSnapshot.data())
        .toList();
    List<EventModel> favouriteEvents = events
        .where(
          (event) =>
              UserModel.currentUser!.favouriteEventIds.contains(event.id),
        )
        .toList();
    return favouriteEvents;
  }
  static Future<void> removeEventFromFavorite(EventModel event) async {
    if (UserModel.currentUser == null) return;
    UserModel currentUser = UserModel.currentUser!;
    currentUser.favouriteEventIds.remove(event.id);
    CollectionReference<UserModel> userCollection = getUserCollection();
    DocumentReference<UserModel> userDocument = userCollection.doc(currentUser.id);
    await userDocument.update({
      'favouriteEventIds': currentUser.favouriteEventIds,
    });
  }

}
