import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/models/add_to_cart_model.dart';
import 'package:ecommerce/models/my_user.dart';
import 'package:ecommerce/services/firestore_services.dart';
import 'package:ecommerce/views/constant/api_path.dart';
import 'package:ecommerce/views/constant/shared_data.dart';
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
        builder: (data, documentId) => Product.fromFirestore(data, documentId),
        queryBuilder: (query) => query.where('discount', isEqualTo: 0));

    return firestoreServices;
  }

  // Future<MyUser?> setUserData(MyUser myUser) async {
  //   await services.setData(
  //       path: ApiPath.user(myUser.id!), data: myUser.toFireStore());
  // }

  // Future<void> addToCart(AddToCart addToCart) async {
  //   services.setData(
  //       path: ApiPath.addToCart(SharedData.myUser?.id??'' , addToCart.id),
  //       data: addToCart.toFirestore());
  // }
  Future<void> addToCart(AddToCart addToCart) async {
    services.cart(addToCart);
  }

  /*
  Stream<List<AddToCart>>? retrivecard (String userId){
    services.retriveCard(userId);
  }

   */

  CollectionReference<AddToCart>? retrivecard(String userId) {
    services.getCardCollection(userId);
  }

// Future<void> setProducts(Product product) async => await services.setData(
//     path: 'products/${product.id}', data: product.toFirestore());

}
