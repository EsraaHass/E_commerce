import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreServices {
  FirestoreServices._();

  static final instance = FirestoreServices._();
  final firestore = FirebaseFirestore.instance;

  Future<void> setData(
      {required String path, required Map<String, dynamic> data}) async {
    DocumentReference docsReferance = firestore.doc(path);
    await docsReferance.set(data);
  }

  Future<void> deleteData({
    required String path,
  }) async {
    DocumentReference docsReferance = firestore.doc(path);
    await docsReferance.delete();
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
