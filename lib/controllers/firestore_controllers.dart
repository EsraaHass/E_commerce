import 'package:ecommerce/models/add_to_cart_model.dart';
import 'package:ecommerce/services/firestore_services.dart';

import '../models/my_user.dart';
import '../models/products.dart';
import '../views/constant/api_path.dart';

abstract class Database {
  Stream<List<Product>> salesproductsStream();

  Stream<List<Product>> newproductsStream();

  Stream<List<AddToCart>> myProductCart();

  Future<void> setUserData(MyUser myUser);

  Future<void> setProducts(Product product);

  Future<void> addToCard(AddToCart cart);
}

class FirestoreDataBase implements Database {
  final services = FirestoreServices.instance;
  String uid;

  FirestoreDataBase(this.uid);

  @override
  Stream<List<Product>> newproductsStream() {
    final firestoreServices = services.collectionStream(
        path: ApiPath.products(),
        builder: (data, documentId) => Product.fromFirestore(data, documentId),
        queryBuilder: (query) => query.where('discount', isEqualTo: 0));

    return firestoreServices;
  }

  @override
  Stream<List<Product>> salesproductsStream() {
    final firestoreServices = services.collectionStream(
        path: ApiPath.products(),
        builder: (data, documentId) => Product.fromFirestore(data, documentId),
        queryBuilder: (query) => query.where('discount', isNotEqualTo: 0));
    return firestoreServices;
  }

  @override
  Future<void> setProducts(Product product) async {
    await services.setData(
        path: 'products/${product.id}', data: product.toFirestore());
  }

  @override
  Future<void> setUserData(MyUser myUser) async {
    await services.setData(
        path: ApiPath.user(myUser.id), data: myUser.toFireStore());
  }

  @override
  Future<void> addToCard(AddToCart cart) async {
    await services.setData(
        path: ApiPath.addToCart(uid, cart.id), data: cart.toFirestore());
  }

  @override
  Stream<List<AddToCart>> myProductCart() {
    return services.collectionStream(
      path: ApiPath.myProductCart(uid),
      builder: (cart, id) => AddToCart.fromFirestore(cart, id),
    );
  }
}
