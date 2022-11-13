import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/models/add_to_cart_model.dart';

import '../models/my_user.dart';

class FirestoreServices {
  FirestoreServices._();

  static final instance = FirestoreServices._();
  final firestore = FirebaseFirestore.instance;

  CollectionReference<MyUser> getUserCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.routeName)
        .withConverter<MyUser>(
            fromFirestore: (snapshot, options) {
              return MyUser.fromFireStore(snapshot.data()!);
            },
            toFirestore: (MyUser, SetOptions) => MyUser.toFireStore());
  }

  CollectionReference<AddToCart> getCardCollection(String userId) {
    return FirebaseFirestore.instance
        .collection(MyUser.routeName)
        .doc(userId)
        .collection('addToCart')
        .withConverter<AddToCart>(
            fromFirestore: (snapshot, options) {
              return AddToCart.fromFirestore(snapshot.data()!);
            },
            toFirestore: (AddToCart, SetOptions) => AddToCart.toFirestore());
  }

  Future<void> cart(AddToCart addToCart) {
    var collectionRefe = getCardCollection(addToCart.id).doc();
    addToCart.id = collectionRefe.id;

    return collectionRefe.set(addToCart);
  }

  /* Stream<List<AddToCart>> retriveCard (String userId){

   return getCardCollection(userId).snapshots().map((event) {
     return event.docs.map((e) => e.data()).toList();
   });
  }


  */

  // Future<void> setData(
  //     {required String path, required Map<String, dynamic> data}) async {
  //   DocumentReference docsReferance = firestore.doc(path);
  //   await docsReferance.set(data);
  // }

  Future<void> deleteData({
    required String path,
  }) async {
    DocumentReference docsReferance = firestore.doc(path);
    await docsReferance.delete();
  }

  Future<MyUser?> setUserData(MyUser myUser) async {
    var collection = getUserCollection();
    var documentRef = collection.doc(myUser.id);
    await documentRef.set(myUser);
    return myUser;
  }

  // documentStream => i will get stream of collection inside of document
  Stream<T> documentStream<T>({
    required String path,
    required T Function(Map<String, dynamic> data, String documentId) builder,
  }) {
    final snapshots = firestore.doc(path).snapshots();
    return snapshots.map((snap) => builder(snap.data()!, snap.id));
  }

  // collectionStream => i will get stream of document inside of collection
  Stream<List<T>> collectionStream<T>({
    required String path,
    required T Function(Map<String, dynamic> data, String documentId) builder,
    Query Function(Query query)? queryBuilder,
    int Function(T lhs, T rhs)? sort,
  }) {
    Query query = firestore.collection(path);
    if (queryBuilder != null) {
      query = queryBuilder(query);
    }
    final snapshots = query.snapshots();
    return snapshots.map((snap) {
      final res = snap.docs
          .map((element) =>
              builder(element.data() as Map<String, dynamic>, element.id))
          .where((value) => value != null)
          .toList();
      return res;
    });
  }
}
