import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_order/Models/profile.dart';

class DatabaseService {
  final String uid;

  // collection reference;

  final CollectionReference profileCollection =
      FirebaseFirestore.instance.collection('profiles');

  DatabaseService({this.uid});

  Profile _profileFromFirebaseUser(DocumentSnapshot snapshot) {
    print('snapshot');
    print(snapshot.data());
    return snapshot.data() == null
        ? null
        : Profile(
            uid: uid,
            firstName: snapshot.data()['firstName'] ?? '',
            lastName: snapshot.data()['lastName'] ?? '',
            avatar: snapshot.data()['avatar'] ?? '',
            address: snapshot.data()['address'] ?? '',
          );
  }

  Stream<Profile> get currentProfile {
    print(uid);
    return profileCollection.doc(uid).snapshots().map(_profileFromFirebaseUser);
  }

// Create profile;

  Future createProfile(
      String firstName, String lastName, String address) async {
    return await profileCollection.doc(uid).set({
      'firstName': firstName,
      'lastName': lastName,
      'address': address,
      'avatar': ''
    });
  }
}
