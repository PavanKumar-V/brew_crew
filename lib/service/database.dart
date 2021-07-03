import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class DatabaseService {
  final String uid;

  var snapshot;
  DatabaseService({required this.uid});
  // collection reference
  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('brews');

  Future updateUserData(String sugars, String name, int strength) async {
    print("database created");
    return await brewCollection.doc(uid).set({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

  // brew list from snapsthot
  List<Brew?> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((dom) {
      return Brew(
          name: dom.get('name') ?? '',
          sugars: dom.get('sugars') ?? '0',
          strength: dom.get('strength') ?? 0);
    }).toList();
  }

  //user data from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        name: snapshot.get('name'),
        sugars: snapshot.get("sugars"),
        strength: snapshot.get('strength'));
  }

  // get brews stream
  Stream<List<Brew?>> get brews {
    return brewCollection
        .snapshots()
        .map((QuerySnapshot? brews) => _brewListFromSnapshot(brews!));
  }

  // get uer doc stream
  Stream<UserData?> get userData {
    return brewCollection
        .doc(uid)
        .snapshots()
        .map((DocumentSnapshot? userData) => _userDataFromSnapshot(userData!));
  }
}
