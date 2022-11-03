import 'package:ecommerce/services/firestore_services.dart';
import 'package:flutter/foundation.dart';

import '../models/products.dart';

class DatabaseViewModel extends ChangeNotifier {
  final services = FirestoreServices.instance;
  final String? uid;

  DatabaseViewModel({this.uid});

  Stream<List<Product>> salesproductsStream() {
    final firestoreServices = services.collectionStream(
        path: 'products/',
        builder: (data, documentId) => Product.fromFirestore(data, documentId),
        queryBuilder: (query) => query.where('discount', isNotEqualTo: 0));
    return firestoreServices;
  }

  Stream<List<Product>> newproductsStream() {
    final firestoreServices = services.collectionStream(
        path: 'products/',
        builder: (data, documentId) => Product.fromFirestore(data, documentId));
    return firestoreServices;
  }

  Future<void> setProducts(Product product) async => await services.setData(
      path: 'products/${product.id}', data: product.toFirestore());
}
