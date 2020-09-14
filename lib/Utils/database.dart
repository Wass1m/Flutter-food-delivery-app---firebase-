import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:food_order/Models/Brand.dart';
import 'package:food_order/Models/food.dart';
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
  final CollectionReference typesCollection =
      FirebaseFirestore.instance.collection('foodTypes');
  final CollectionReference foodCollection =
      FirebaseFirestore.instance.collection('food');

  DatabaseService({this.uid});

  Profile _profileFromFirebaseUser(DocumentSnapshot snapshot) {
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

// create a new profile
  Future createProfile(
      String firstName, String lastName, String address) async {
    return await profileCollection.doc(uid).set({
      'firstName': firstName,
      'lastName': lastName,
      'address': address,
      'avatar': ''
    });
  }

// get stores
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
        foodTypes: doc.data()['foodTypes'] ?? [''],
      );
    }).toList();
  }

  // Stream<List<Store>> get stores {
  //   return storeCollection.snapshots().map(_storeFromFirebase);
  // }

  Stream<List<Store>> getFilteredStores({String filter = 'All'}) {
    if (filter == 'All') {
      return storeCollection.snapshots().map(_storeFromFirebase);
    }
    return storeCollection
        .where("foodTypes", arrayContains: filter)
        .snapshots()
        .map(_storeFromFirebase);
  }

  List<FoodType> _typesFromFirebase(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return FoodType(
        name: doc.data()['name'] ?? '',
        image: doc.data()['image'] ?? '',
      );
    }).toList();
  }

  Stream<List<FoodType>> get allTypes {
    return typesCollection.snapshots().map(_typesFromFirebase);
  }

  List<Food> _foodFromFirebase(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Food(
        name: doc.data()['name'] ?? '',
        image: doc.data()['image'] ?? '',
        type: doc.data()['type'] ?? '',
        price: doc.data()['price'] ?? 0,
        size: doc.data()['size'] ?? [''],
        weight: doc.data()['weight'] ?? 0,
        calories: doc.data()['calories'] ?? 0,
      );
    }).toList();
  }

  Stream<List<Food>> getfoodList(List<String> foods) {
    var list = List<String>.from(foods);
    print(list);
    return foodCollection
        .where(FieldPath.documentId, whereIn: list)
        .snapshots()
        .map(_foodFromFirebase);
  }
}
