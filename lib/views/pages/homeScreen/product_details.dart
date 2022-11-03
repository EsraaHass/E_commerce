import 'package:ecommerce/models/products.dart';
import 'package:ecommerce/views/constant/main_button.dart';
import 'package:flutter/material.dart';

class ProductDetails extends StatefulWidget {
  static const String routeName = 'ProductDetails';

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  bool isFavourite = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var product = ModalRoute.of(context)?.settings.arguments as Product;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 254, 252, 252),
      appBar: AppBar(
        actions: const [
          Icon(Icons.share),
          const SizedBox(
            width: 10,
          )
        ],
        centerTitle: true,
        title: Text(
          product.title,
          style:
              Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              height: size.height * 0.5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      height: 45,
                      width: 50,
                      child: DecoratedBox(
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              isFavourite = !isFavourite;
                            });
                          },
                          icon: Icon(
                            Icons.favorite,
                            size: 30,
                            color:
                                isFavourite ? Colors.red : Colors.grey.shade400,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 13,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.title,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                                fontWeight: FontWeight.w600, fontSize: 20),
                      ),
                      Text(
                        '\$${product.price}',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                                fontWeight: FontWeight.w600, fontSize: 20),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                    'A t-shirt is a piece of fabric that wraps'
                    ' our shoulders and arms and has short sleeves.'
                    ' T-shirts are made of an elastic, light,'
                    ' and inexpensive fabric that is quite ',
                    textDirection: TextDirection.ltr,
                  ),
                  SizedBox(height: size.height * 0.15),
                  MainButton(
                    text: 'Add To Cart',
                    voidCallback: () {},
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
