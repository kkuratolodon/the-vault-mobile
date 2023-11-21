import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:the_vault_mobile/models/item.dart';
import 'package:the_vault_mobile/screens/item_detail.dart';
import 'package:the_vault_mobile/widgets/left_drawer.dart';

class ItemPage extends StatefulWidget {
  const ItemPage({Key? key}) : super(key: key);

  @override
  _ItemPageState createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  Future<List<Item>> fetchItem() async {
    // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
    var url =
        Uri.parse('https://muhammad-irfan25-tugas.pbp.cs.ui.ac.id/auth/json/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object Item
    List<Item> list_Item = [];
    for (var d in data) {
      if (d != null) {
        list_Item.add(Item.fromJson(d));
      }
    }
    return list_Item;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Item'),
        ),
        drawer: const LeftDrawer(),
        body: FutureBuilder(
            future: fetchItem(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (!snapshot.hasData) {
                  return const Column(
                    children: [
                      Text(
                        "Tidak ada data produk.",
                        style:
                            TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                      ),
                      SizedBox(height: 8),
                    ],
                  );
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (_, index) => Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${snapshot.data![index].fields.name}",
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                    "Amount: ${snapshot.data![index].fields.amount}"),
                                const SizedBox(height: 10),
                                Text(
                                    "Rating: ${snapshot.data![index].fields.rating}"),
                                const SizedBox(height: 10),
                                Text(
                                    "Image Link: ${snapshot.data![index].fields.image}"),
                                const SizedBox(height: 10),
                                Text(
                                    "${snapshot.data![index].fields.description}"),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailItemPage(
                                            item: snapshot.data![index]),
                                      ),
                                    );
                                  },
                                  child: const Text('Detail Item'),
                                ),
                              ],
                            ),
                          ));
                }
              }
            }));
  }
}
