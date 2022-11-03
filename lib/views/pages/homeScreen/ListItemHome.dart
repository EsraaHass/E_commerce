import 'package:ecommerce/views/pages/homeScreen/product_details.dart';
import 'package:flutter/material.dart';

import '../../../models/products.dart';

class ListItemHome extends StatelessWidget {
  Product product;

  ListItemHome(this.product);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.topLeft,
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context, rootNavigator: true)
                      .pushNamed(ProductDetails.routeName, arguments: product);
                },
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(19),
                    child: Image.network(
                      product.imageUrl,
                      height: size.height * 0.20,
                      width: 200,
                      fit: BoxFit.cover,
                    )),
              ),
              Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12)),
                  child: Text(
                    '${product.discount}%',
                    style: TextStyle(color: Colors.white),
                  )),
            ],
          ),
          const SizedBox(
            height: 6,
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
      ),
    );
  }
}
