import 'package:flutter/material.dart';
import 'package:the_vault_mobile/widgets/inv_card.dart';
import 'package:the_vault_mobile/widgets/left_drawer.dart';


class InvItem {
  final String name;
  final IconData icon;
  final Color color;
  InvItem(this.name, this.icon, this.color);
}

class MyHomePage extends StatelessWidget {
  // Konstruktor dengan key opsional
  MyHomePage({Key? key}) : super(key: key);

  // Daftar item toko
  final List<InvItem> items = [
    InvItem("Lihat Item", Icons.checklist, const Color(0xFF004D40)),
    InvItem("Tambah Item", Icons.add_shopping_cart, const Color(0xFF311B92)),
    InvItem("Logout", Icons.logout, const Color(0xFF800000)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('The Vault'),
        backgroundColor: Colors.deepPurple  ,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Text(
                  'Album Collection',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              GridView.count(
                primary: true,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 3,
                shrinkWrap: true,
                children: items.map((InvItem item) {
                  return InvCard(item);
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

