# Tugas 7 PBP
Muhammad Irfan Firmansyah (2206816102) <br>
PBP-B <br>


## Apa perbedaan utama antara stateless dan stateful widget dalam konteks pengembangan aplikasi Flutter?
+ Stateless Widget
    + Bersifat statis, artinya tidak akan pernah dirubah setelah dibuat.
    + Perubahan pada Stateless Widget dipengaruhi oleh peristiwa eksternal pada widget induk dalam pohon widget.
    + Stateless Widget mengendalikan cara mereka dibangun (render) oleh widget induk yang mereka masuki.
    + Widget anak Stateless Widget menerima deskripsinya dari widget induk dan tidak mengubahnya sendiri.
    + Stateless Widget hanya memiliki properti akhir (final) yang didefinisikan selama konstruksi, dan itulah satu-satunya yang perlu dibangun di layar perangkat.
+ Stateful Widget
    + Stateful Widget dapat mengubah deskripsi (state) secara dinamis selama hidupnya.
    + Meskipun widget Stateful itu sendiri bersifat tidak berubah (immutable), mereka memiliki kelas State yang terkait yang mewakili keadaan saat ini dari widget tersebut. State inilah yang dapat berubah dan mempengaruhi tampilan widget.
    + Stateful Widget digunakan ketika perlu melacak dan mengubah data atau keadaan selama siklus hidup widget, seperti mengganti teks dalam sebuah teks input atau mengubah tampilan widget berdasarkan tindakan pengguna.

## Sebutkan seluruh widget yang kamu gunakan untuk menyelesaikan tugas ini dan jelaskan fungsinya masing-masing.

+ `MyHomePage` (StatelessWidget): Ini adalah widget utama yang mewakili halaman beranda aplikasi. Ini adalah tampilan utama yang berisi daftar item toko.
+ `Scaffold`: Ini adalah widget yang menyediakan kerangka kerja dasar untuk halaman. Ini berisi AppBar dan body.
+ `AppBar`: Widget ini digunakan untuk menampilkan bilah aplikasi di bagian atas halaman dengan judul "Minechesty".
+ `Text`: Digunakan untuk menampilkan teks "Minechesty" dalam judul AppBar.
+ `ScaffoldMessenger`: Digunakan untuk menampilkan pesan snack bar saat salah satu item di toko ditekan.
+ `SnackBar`: Ini adalah pesan pop-up sementara yang muncul ketika salah satu item di toko ditekan.
+ `SingleChildScrollView`: Widget ini digunakan untuk membungkus seluruh konten halaman sehingga dapat discroll jika kontennya lebih panjang dari layar.
+ `Padding`: Digunakan untuk memberikan padding ke dalam konten yang berisi judul dan daftar item toko.
+ `Column`: Ini adalah widget yang digunakan untuk menampilkan anak-anak (children) secara vertikal.
+ `GridView.count`: Ini adalah widget yang digunakan untuk membuat tata letak grid dengan jumlah kolom yang diberikan.
+ `ShopItem`: Ini adalah kelas yang digunakan untuk mewakili item toko. Masing-masing item memiliki nama, ikon, dan warna.
+ `ShopCard`: Ini adalah widget yang digunakan untuk menampilkan setiap item toko dalam bentuk kartu. Widget ini berisi ikon dan teks, serta merespons ketika ditekan untuk menampilkan snack bar.
+ `Material`: Ini adalah widget yang digunakan untuk mengatur latar belakang warna kartu.
+ `InkWell`: Digunakan untuk memberikan area responsif terhadap sentuhan sehingga item toko bisa ditekan.
+ `Container`: Ini adalah widget yang digunakan untuk mengelompokkan ikon dan teks dalam kartu.
+ `Icon`: Digunakan untuk menampilkan ikon yang terkait dengan item toko.
+ `Text`: Digunakan untuk menampilkan nama item toko dalam kartu.

## 3. Checklist Tugas
- [x] Membuat sebuah program Flutter baru dengan tema inventory seperti tugas-tugas sebelumnya.
1. Menjalankan `flutter create the-vault-mobile` untuk membuat project flutter baru
2. Memindahkan class `MyHomePage` dari `main.dart` ke `menu.dart`
- [x] Membuat tiga tombol sederhana dengan ikon dan teks & Memunculkan Snackbar dengan tulisan ketika ditekan.
1. membuat class `InvItem` untuk setiap tombolnya
    ```dart
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
    ```
3. Membuat widget baru `InvCard`yang berada di dalam widget sebelumnya, dan menambahkan fungsi saat ditekan tombolnya muncul tulisan
    ```dart
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

    ```