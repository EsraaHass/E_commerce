import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/models/add_to_cart_model.dart';
import 'package:ecommerce/viewModels/database_viewmodel.dart';
import 'package:ecommerce/views/constant/shared_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cart_List)Item.dart';

class Cart extends StatefulWidget {
  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  late DatabaseViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = DatabaseViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => viewModel,
      child: SafeArea(
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
              StreamBuilder<QuerySnapshot<AddToCart>>(
                  stream: viewModel
                      .retrivecard(SharedData.myUser?.id ?? '')
                      ?.snapshots(),
                  builder: (context, snapshot) {
                    var data =
                        snapshot.data?.docs.map((e) => e.data()).toList();

                    if (snapshot.connectionState == ConnectionState.active) {
                      if (data == null || data.isEmpty) {
                        const Center(
                          child: Text('No Data Available !'),
                        );
                      }

                      if (data != null && data.isNotEmpty) {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemBuilder: (_, index) =>
                              CartListItem(addToCart: data[index]),
                          itemCount: data.length,
                        );
                      }
                    }

                    print('error is ${data.toString()}');
                    return Text('error ${data.toString()}');
                  })
            ],
          ),
        ),
      )),
    );
  }
}
