import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_order/Models/Brand.dart';
import 'package:food_order/Models/profile.dart';
import 'package:food_order/Models/store.dart';

class DatabaseService {
  final String uid;

  // collection reference;

  final CollectionReference profileCollection =
      FirebaseFirestore.instance.collection('profiles');
  final CollectionReference storeCollection =
      FirebaseFirestore.instance.collection('food-store');
  final CollectionReference brandsCollection =
      FirebaseFirestore.instance.collection('brands');

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

  // Brand _brandFromFirebase(DocumentSnapshot snapshot) {
  //   return Brand(
  //     name: snapshot.data()['name'] ?? '',
  //     image: snapshot.data()['image'] ?? '',
  //   );
  // }

  Future createProfile(
      String firstName, String lastName, String address) async {
    return await profileCollection.doc(uid).set({
      'firstName': firstName,
      'lastName': lastName,
      'address': address,
      'avatar': ''
    });
  }

  List<Store> _storeFromFirebase(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      // print(doc.data());
      return Store(
        brand: doc.data()['brand'] ?? '',
        name: doc.data()['name'] ?? '',
        location: doc.data()['location'] ?? '',
        rating: doc.data()['rating'] ?? 0,
        menu: doc.data()['menu'] ?? '',
        image: doc.data()['image'] ?? '',
      );
    }).toList();
  }

  Stream<List<Store>> get stores {
    return storeCollection.snapshots().map(_storeFromFirebase);
  }
}
