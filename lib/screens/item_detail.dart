import 'package:flutter/material.dart';
import 'package:the_vault_mobile/models/item.dart';
import 'package:the_vault_mobile/widgets/left_drawer.dart';

class DetailItemPage extends StatefulWidget {
  final Item item;

  const DetailItemPage({super.key, required this.item});

  @override
  State<DetailItemPage> createState() => _DetailItemPageState();
}

class _DetailItemPageState extends State<DetailItemPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Detail Item',
          ),
        ),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              '${widget.item.fields.image}',
              fit: BoxFit.cover, // Adjust the fit property as needed
              width: 200.0, // Set the width to limit the size
              height: 200.0, // Set the height to limit the size
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              (loadingProgress.expectedTotalBytes ?? 1)
                          : null,
                    ),
                  );
                }
              },
            ),
            const Text(
              'Item Name:',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              widget.item.fields.name,
              style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              'Amount: ${widget.item.fields.amount}',
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              'Rating: ${widget.item.fields.rating}',
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              'Description: ${widget.item.fields.description}',
              style: const TextStyle(fontSize: 18),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigasi kembali ketika tombol ditekan
                Navigator.pop(context);
              },
              child: const Text('Kembali'),
            ),
          ],
        ),
      ),
    );
  }
}
