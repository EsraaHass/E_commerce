import 'package:ecommerce/views/pages/homeScreen/product_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../../../controllers/firestore_controllers.dart';
import '../../../models/products.dart';
import '../../constant/favourite_components.dart';

class ListItemHome extends StatelessWidget {
  Product product;
  bool isSale;

  ListItemHome({required this.product, required this.isSale});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final database = Provider.of<Database>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.topLeft,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(19),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context, rootNavigator: true).pushNamed(
                        ProductDetails.routeName,
                        arguments: {'product': product, 'database': database});
                  },
                  child: Image.network(
                    product.imageUrl,
                    height: size.height * 0.20,
                    width: 200,
                    fit: BoxFit.cover,
                  ),
                )),
            Container(
                margin: const EdgeInsets.all(10),
                padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                decoration: BoxDecoration(
                    color: isSale ? Colors.red : Colors.black,
                    borderRadius: BorderRadius.circular(12)),
                child: Text(
                  isSale ? '${product.discount}%' : 'NEW',
                  style: const TextStyle(color: Colors.white),
                )),
            Positioned(bottom: 5, right: 10, child: FavouriteIcon()),
          ],
        ),
        RatingBarIndicator(
          rating: product.rate?.toDouble() ?? 4.0,
          itemBuilder: (context, index) => const Icon(
            Icons.star,
            color: Colors.amber,
          ),
          itemSize: 25.0,
          direction: Axis.horizontal,
          itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          product.category,
          style: Theme.of(context)
              .textTheme
              .bodyText2
              ?.copyWith(color: Colors.grey),
        ),
        const SizedBox(
          height: 6,
        ),
        Text(
          product.title,
          style: Theme.of(context).textTheme.bodyMedium,
        ),

        //  Text.rich(
        //   TextSpan(
        //     children: [
        //      TextSpan(
        //        text: '${product.price}\$',
        //        style: Theme.of(context)
        //            .textTheme
        //            .bodyText2?.copyWith(
        //            color: Colors.grey,
        //            decoration: TextDecoration.lineThrough
        //        ),
        //      ),
        //       TextSpan(
        //         text: '  ${product.price *(product.discount)/100}\$',
        //       )
        //     ],
        //   ),
        //
        // ),
      ],
    );
  }
}
