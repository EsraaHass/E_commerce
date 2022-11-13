import 'package:ecommerce/models/add_to_cart_model.dart';
import 'package:flutter/material.dart';

class CartListItem extends StatelessWidget {
  AddToCart? addToCart;

  CartListItem({this.addToCart});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Row(
        children: [
          Image.network(
            addToCart?.imageUrl ?? '',
            width: 80,
            height: 80,
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text(addToCart?.title ?? ''), Icon(Icons.more_vert)],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Text(addToCart?.color ?? 'Black'),
                  const SizedBox(
                    width: 10,
                  ),
                  Text('size : L'),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
