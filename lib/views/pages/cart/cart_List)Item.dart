import 'package:ecommerce/models/add_to_cart_model.dart';
import 'package:flutter/material.dart';

class CartListItem extends StatelessWidget {
  AddToCart? addToCart;

  CartListItem({this.addToCart});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Card(
        elevation: 12,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        child: SizedBox(
          height: size * 0.15,
          child: Row(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(14),
                    bottomLeft: Radius.circular(14)),
                child: Image.network(
                  addToCart?.imageUrl ?? '',
                  width: 100,
                  height: size,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(addToCart?.title ?? ''),
                        const Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Icon(
                            Icons.more_vert,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text.rich(TextSpan(children: [
                          TextSpan(
                              text: 'Color: ',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: Colors.grey, fontSize: 12)),
                          TextSpan(
                              text: 'Black',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontSize: 12)),
                        ])),
                        const SizedBox(
                          width: 14,
                        ),
                        Text.rich(TextSpan(children: [
                          TextSpan(
                              text: 'Size: ',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: Colors.grey, fontSize: 12)),
                          TextSpan(
                              text: 'L',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: Colors.grey, fontSize: 12)),
                        ])),
                      ],
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Align(
                          alignment: Alignment.bottomRight,
                          child: Text('${addToCart?.price}\$')),
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
