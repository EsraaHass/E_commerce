class AddToCart {
  String id;
  String productid;
  String title;
  String imageUrl;
  String color;

  //final String size;
  final int price;
  final int discount;
  final int quentity;

  AddToCart(
      {required this.id,
      required this.productid,
      required this.title,
      required this.imageUrl,
      this.color = 'Black',
      // required this.size,
      required this.price,
      this.discount = 0,
      this.quentity = 1});

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'title': title,
      'productid': productid,
      'imageUrl': imageUrl,
      'price': price,
      'discount': discount,
      // 'size': size,
      'color': color,
      'quentity': quentity
    };
  }

  factory AddToCart.fromFirestore(Map<String, dynamic> data) {
    return AddToCart(
      id: data['id'] as String,
      productid: data['productid'] as String,
      title: data['title'] as String,
      quentity: data['quentity'] as int,
      imageUrl: data['imageUrl'] as String,
      price: data['price'] as int,
      discount: data['discount'] as int,
      color: data['color'] as String,
      // size: data['size'] ?? ''
    );
  }
}
