import 'package:ecommerce/models/add_to_cart_model.dart';
import 'package:ecommerce/models/products.dart';
import 'package:ecommerce/views/constant/constant.dart';
import 'package:ecommerce/views/constant/favourite_components.dart';
import 'package:ecommerce/views/constant/main_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controllers/firestore_controllers.dart';
import '../../constant/drop_down_menu.dart';

class ProductDetails extends StatefulWidget {
  static const String routeName = 'ProductDetails';

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  bool isFavourite = false;

  // late String dropdown ;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    Product product = args['product'];
    Database database = args['database'];
    return Provider<Database>.value(
      value: database,
      child: Scaffold(
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: SizedBox(height: 60, child: DropDowmNenu())),
                        const Spacer(),
                        FavouriteIcon(),
                      ],
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
                    SizedBox(height: size.height * 0.11),
                    MainButton(
                      text: 'Add To Cart',
                      // ToDo: must refactor this part.
                      voidCallback: () async {
                        AddToCart cart = AddToCart(
                          id: idFromLocalData(),
                          title: product.title,
                          productid: product.id,
                          imageUrl: product.imageUrl,
                          // size: dropdown,
                          price: product.price,
                        );
                        await database.addToCard(cart);
                      },
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
      ),
    );
  }
}
