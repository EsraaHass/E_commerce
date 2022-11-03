import '../views/constant/images_url.dart';

class Product {
  final String id;
  final String title;
  final String imageUrl;
  final int price;
  final int? discount;
  final int? rate;
  final String category;

  Product({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.price,
    this.discount,
    this.category = 'Other',
    this.rate,
  });

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'title': title,
      'imageUrl': imageUrl,
      'price': price,
      'discount': discount,
      'rate': rate,
      'category': category
    };
  }

  factory Product.fromFirestore(Map<String, dynamic> data, String documentId) {
    return Product(
        id: documentId,
        title: data['title'] as String,
        category: data['category'] as String,
        imageUrl: data['imageUrl'] as String,
        price: data['price'] as int,
        discount: data['discount'] as int,
        rate: data['rate'] as int);
  }
}

List<Product> getProduct = [
  Product(
      id: 't-shirt',
      title: 'T-shirt',
      category: 'Clothes',
      imageUrl: ImagesUrl.clothImage,
      price: 300,
      discount: 20),
  Product(
      id: 't-shirt',
      title: 'T-shirt',
      category: 'Clothes',
      imageUrl: ImagesUrl.clothImage,
      price: 300,
      discount: 20),
  Product(
      id: 't-shirt',
      title: 'T-shirt',
      category: 'Clothes',
      imageUrl: ImagesUrl.clothImage,
      price: 300,
      discount: 20),
  Product(
      id: 't-shirt',
      title: 'T-shirt',
      category: 'Clothes',
      imageUrl: ImagesUrl.clothImage,
      price: 300,
      discount: 20),
  Product(
      id: 't-shirt',
      title: 'T-shirt',
      category: 'Clothes',
      imageUrl: ImagesUrl.clothImage,
      price: 300,
      discount: 20),
  Product(
      id: 't-shirt',
      title: 'T-shirt',
      category: 'Clothes',
      imageUrl: ImagesUrl.clothImage,
      price: 300,
      discount: 20),
  Product(
      id: 't-shirt',
      title: 'T-shirt',
      category: 'Clothes',
      imageUrl: ImagesUrl.clothImage,
      price: 300,
      discount: 20),
  Product(
      id: 't-shirt',
      title: 'T-shirt',
      category: 'Clothes',
      imageUrl: ImagesUrl.clothImage,
      price: 300,
      discount: 20),
];
