import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

import '../order.dart';
import '../tiles/product_tile.dart';

class Kids extends StatefulWidget {
  const Kids({Key? key}) : super(key: key);

  @override
  State<Kids> createState() => _KidsState();
}

class _KidsState extends State<Kids> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("products").snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              List<QueryDocumentSnapshot<Object?>> firestoreitems =
                  snapshot.data!.docs;
              return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: StaggeredGrid.count(
                      crossAxisCount: 2,
                      children: List.generate(
                          firestoreitems.length,
                          ((index) => "Kids" ==
                                      firestoreitems[index]['category']
                                          .toString() ||
                                  "All" ==
                                      firestoreitems[index]
                                              ['category']
                                          .toString() ||
                                  "Men,Kids" ==
                                      firestoreitems[index]['category']
                                          .toString() ||
                                  "Women,Kids" ==
                                      firestoreitems[index]['category']
                                          .toString()
                              ? ProductTile(
                                  image: firestoreitems[index]['image'],
                                  title: firestoreitems[index]['productName'],
                                  desc: firestoreitems[index]['description'],
                                  price:
                                      firestoreitems[index]['price'].toString(),
                                  discount: firestoreitems[index]['discount']
                                      .toString(),
                                  onTap: () {
                                    Get.to(() => OrderPage(
                                          url: firestoreitems[index]['image'],
                                          price: firestoreitems[index]['price']
                                              .toString(),
                                          title: firestoreitems[index]
                                              ['productName'],
                                          discount: firestoreitems[index]
                                                  ['discount']
                                              .toString(),
                                          description: firestoreitems[index]
                                              ['description'],
                                          brandStore: firestoreitems[index]
                                              ['brand_store'],
                                          category: firestoreitems[index]
                                              ['category'],
                                          offer: firestoreitems[index]['offer'],
                                          productId: firestoreitems[index]
                                              ['productID'],
                                          type: firestoreitems[index]['type'],
                                        ));
                                  },
                                )
                              : const SizedBox()))));
            }
          }),
    );
  }
}
