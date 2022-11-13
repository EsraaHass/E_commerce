import 'package:ecommerce/controllers/firestore_controllers.dart';
import 'package:ecommerce/models/add_to_cart_model.dart';
import 'package:ecommerce/views/constant/main_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cart_List)Item.dart';

class Cart extends StatefulWidget {
  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    var database = Provider.of<Database>(context);
    return SafeArea(
        child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [SizedBox.shrink(), Icon(Icons.search)],
            ),
            const SizedBox(
              height: 16.0,
            ),
            Text(
              'My Cart',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(
              height: 20.0,
            ),
            StreamBuilder<List<AddToCart>>(
                stream: database.myProductCart(),
                builder: (context, snapshot) {
                  var data = snapshot.data;

                  if (snapshot.connectionState == ConnectionState.active) {
                    if (data == null || data.isEmpty) {
                      const Center(
                        child: Text('No Data Available !'),
                      );
                    }

                    if (data != null && data.isNotEmpty) {
                      return ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: 5,
                          );
                        },
                        shrinkWrap: true,
                        itemBuilder: (_, index) =>
                            CartListItem(addToCart: data[index]),
                        itemCount: data.length,
                      );
                    }
                  }

                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }),
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total Amount:',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.grey, fontSize: 12)),
                  Text('124\$', style: Theme.of(context).textTheme.bodyMedium)
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            MainButton(
              text: 'CHECK OUT',
              voidCallback: () {},
            ),
            const SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    ));
  }
}
