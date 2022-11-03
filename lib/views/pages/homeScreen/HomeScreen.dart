import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/products.dart';
import '../../../viewModels/database_viewmodel.dart';
import '../../constant/buildHeaderOfList.dart';
import '../../constant/images_url.dart';
import 'ListItemHome.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late DatabaseViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = DatabaseViewModel();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    // final database = Provider.of<DatabaseViewModel>(context);
    return ChangeNotifierProvider(
      create: (_) => viewModel,
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Image.network(
                ImagesUrl.mainImage,
                height: height * .3,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Opacity(
                opacity: 0.4,
                child: Container(
                  width: double.infinity,
                  height: height * .3,
                  color: Colors.black,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 24, horizontal: 24),
                child: Text(
                  'Street Clothes',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: Colors.white),
                ),
              )
            ],
          ),
          Expanded(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BuildHeaderOfList('Sale', 'Super Summer Sale!', () {}),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .3,
                        child: StreamBuilder<List<Product>>(
                            stream: viewModel.salesproductsStream(),
                            builder: (context, snapshot) {
                              final data = snapshot.data;

                              if (snapshot.connectionState ==
                                  ConnectionState.active) {
                                if (data == null || data.isEmpty) {
                                  return const Center(
                                    child: Text('No Data Available !'),
                                  );
                                }
                                return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return ListItemHome(data[index]);
                                  },
                                  itemCount: data.length,
                                  // children: getProduct.map((product) => ListItemHome(product)).toList(),
                                );
                              }
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }),
                      ),
                      BuildHeaderOfList('New', 'Super New Products!', () {}),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .3,
                        child: StreamBuilder<List<Product>>(
                            stream: viewModel.newproductsStream(),
                            builder: (context, snapshot) {
                              final data = snapshot.data;

                              if (snapshot.connectionState ==
                                  ConnectionState.active) {
                                if (data == null || data.isEmpty) {
                                  return const Center(
                                    child: Text('No Data Available !'),
                                  );
                                }
                                return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return ListItemHome(data[index]);
                                  },
                                  itemCount: data.length,
                                  // children: getProduct.map((product) => ListItemHome(product)).toList(),
                                );
                              }
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
