class ApiPath {
  static String products() => 'products/';

  static String user(String uid) => 'users/$uid';

  static String addToCart(String uid, String addtoCartId) =>
      'users/$uid/addToCart/';
}
