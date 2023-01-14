import 'package:flutter/material.dart';
import 'package:restapi/services/api_services.dart';

import 'models/post_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Rest Api",
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: RestApp());
  }
}

class RestApp extends StatefulWidget {
  const RestApp({super.key});

  @override
  State<RestApp> createState() => _RestAppState();
}

class _RestAppState extends State<RestApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Rest Api"),
        ),
        body: FutureBuilder(
          future: getposts(),
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              List<Product?> product = snapshot.data;
              return Container(
                child: ListView.builder(
                  itemCount: product.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        leading: SizedBox(
                          height: 70,
                          width: 70,
                          child: Image.network(product[index]!.thumbnail!),
                        ),
                        title: Text("${product[index]!.title}"),
                        subtitle: Row(
                          children: [
                            Expanded(
                                child: Text("${product[index]!.description}")),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(" ${product[index]!.price}"),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          },
        ));
  }
}
