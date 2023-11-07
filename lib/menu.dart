import 'package:flutter/material.dart';

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
      ),
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

class InvCard extends StatelessWidget {
  final InvItem item;

  const InvCard(this.item, {super.key}); // Constructor

  @override
  Widget build(BuildContext context) {
    return Material(
      color: item.color,
      child: InkWell(
        // Area responsive terhadap sentuhan
        onTap: () {
          // Memunculkan SnackBar ketika diklik
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
                content: Text("Kamu telah menekan tombol ${item.name}!")));
        },
        child: Container(
          // Container untuk menyimpan Icon dan Text
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.icon,
                  color: Colors.white,
                  size: 30.0,
                ),
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
