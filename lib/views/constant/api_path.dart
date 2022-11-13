class ApiPath {
  static String products() => 'products/';

  static String user(String uid) => 'users/$uid';

  static String addToCart(String uid, String addtoCartId) =>
      'users/$uid/cart/$addtoCartId';

  static String myProductCart(String uid) => 'users/$uid/cart/';
}
