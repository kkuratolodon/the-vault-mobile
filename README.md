
Muhammad Irfan Firmansyah (2206816102) <br>
PBP-B <br>

# Tugas 9

## Apakah bisa kita melakukan pengambilan data JSON tanpa membuat model terlebih dahulu? Jika iya, apakah hal tersebut lebih baik daripada membuat model sebelum melakukan pengambilan data JSON?
Ya, kita dapat melakukan pengambilan data JSON tanpa membuat model terlebih dahulu. Jika kita hanya mengambil data dari sebuah file JSON atau API dan tidak perlu melakukan manipulasi atau analisis yang kompleks, kita tidak perlu membuat model khusus. Lebih baik atau tidaknya itu tergantung dari kebutuhan kita, jika kita hanya butuh untuk mengambil dan menganalisis data JSON secara sederhana, maka tidak perlu membuat model terlebih dahulu. Namun, jika kita ingin melakukan tugas seperti klasifikasi atau prediksi berdasarkan data JSON, maka kita mungkin perlu membuat model terlebih dahulu. Jika struktur kita kompleks, maka membangun model merupakan keputusan yang lebih baik dikarenakan model membantu kita dalam mengatasi kompleksitas struktur data, dan mengekstrak informasi. <br>

## Jelaskan fungsi dari CookieRequest dan jelaskan mengapa instance CookieRequest perlu untuk dibagikan ke semua komponen di aplikasi Flutter.

`CookieRequest` berfungsi untuk mengatur berbagai permintaan HTTP dan pengelola cookie dalam aplikasi Flutter. Dengan instance CookieRequest yang dibagikan melalui `Provider` ke semua komponen, informasi autentikasi dan sesi dapat diakses secara konsisten di seluruh aplikasi. Ini memudahkan setiap widget untuk berinteraksi dengan layanan web, menjadikan manajemen state dan autentikasi lebih efisien. <br>

Pembagian instance CookieRequest secara global memastikan keseragaman dan kemudahan akses ke data sesi tanpa perlu membuat instance baru atau mentransfer informasi secara manual antar komponen. Dengan demikian, penggunaan Provider mempermudah pengelolaan status otentikasi di seluruh aplikasi dan memastikan bahwa setiap bagian dari aplikasi dapat dengan mudah berpartisipasi dalam operasi otentikasi atau interaksi dengan layanan web. <br>

## Jelaskan mekanisme pengambilan data dari JSON hingga dapat ditampilkan pada Flutter.
  + Pertama-tama membuat model item. Disini saya mengambil endpoint json dari tugas 6 lalu menggunakan website `quicktype` untuk diubah menjadi model Item. Lalu saya Copy Codenya ke dalam berkas `item.dart` yang berada pada folder `models`.
  + Menambahkan dependensi http dengan run perintah dibawah ini:
  ```
  flutter pub add http
  ```
  + Pada file `android/app/src/main/AndroidManifest.xml` tambahkan kode berikut:
  ```
  ...
    <application>
    ...
    </application>
    <!-- Required to fetch data from the Internet. -->
    <uses-permission android:name="android.permission.INTERNET" />
  ...
  ```
  + Membuat berkas `list_product.dart` pada folder `lib/screens`
  + Pada file `list_item.dart` tambahkan kode berikut:
  ```
  import 'package:flutter/material.dart';
  import 'package:http/http.dart' as http;
  import 'dart:convert';
  import 'package:<APP_NAME>/models/product.dart';
  ```
  ```
  class ProductPage extends StatefulWidget {
    const ProductPage({Key? key}) : super(key: key);

    @override
    _ProductPageState createState() => _ProductPageState();
  }

  class _ProductPageState extends State<ProductPage> {
  Future<List<Item>> fetchProduct() async {
      var url = Uri.parse(
          'http://127.0.0.1:8000/main/get-item/');
      var response = await http.get(
          url,
          headers: {"Content-Type": "application/json"},
      );

      // melakukan decode response menjadi bentuk json
      var data = jsonDecode(utf8.decode(response.bodyBytes));

      // melakukan konversi data json menjadi object Product
      List<Item> list_product = [];
      for (var d in data) {
          if (d != null) {
              list_product.add(Item.fromJson(d));
          }
      }
      return list_product;
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
            appBar: AppBar(
              title: const Center(
                child: Text(
                  'List Item',
                ),
              ),
              backgroundColor: Colors.indigo,
              foregroundColor: Colors.white,
            ),
          drawer: const LeftDrawer(),
          body: FutureBuilder(
              future: fetchProduct(),
              builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                      return const Center(child: CircularProgressIndicator());
                  } else {
                      if (!snapshot.hasData) {
                      return const Column(
                          children: [
                          Text(
                              "Tidak ada data Item.",
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
                                  child: InkWell(
                                    child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                        Text(
                                        "${index + 1}. ${snapshot.data![index].fields.name}",
                                        style: const TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                        ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text("${snapshot.data![index].fields.amount}"),
                                        const SizedBox(height: 10),
                                        Text("${snapshot.data![index].fields.description}"),
                                        const SizedBox(height: 10),
                                        Text("${snapshot.data![index].fields.rarity}"),
                                          ElevatedButton(
                                            onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => DetailItemPage(item: snapshot.data![index]),
                                              ),
                                            );
                                        },
                                        child: const Text('Detail Item'),
                                      ),
                                    ],
                                    ),
                                  )
                              ));
                      }
                  }
              }));
      }
  }
  ```

## Jelaskan mekanisme autentikasi dari input data akun pada Flutter ke Django hingga selesainya proses autentikasi oleh Django dan tampilnya menu pada Flutter.

  + Meminta input mengenai username dan password di Flutter.
  + Menggunakan metode http.post untuk mengirim informasi data login user ke server Django
  + Setelah django mendapatkan data informasi login, django akan memverifikasi informasi login. Jika valid, maka django akan mengembalikan token autentikasi.
  + Setelah autentikasi berhasil, tampilan menu atau akses ke fitur tertentu yang memerlukan autentikasi akan di tampilkan di aplikasi flutter.

## Sebutkan seluruh widget yang kamu pakai pada tugas ini dan jelaskan fungsinya masing-masing.
  + `http`: Ditambahkan sebagai dependensi untuk membuat permintaan HTTP
  + `FutureBuilder`: Digunakan untuk membangun widget secara asinkron berdasarkan snapshot terbaru dari data.
  + `Provider` : Digunakan untuk mengelola dan menyediakan state dari kelas `CookieRequest` ke semua widget anak.
  + `Elevated Button`: Untuk membuat button
  + `Text`: Menampilkan teks
  + `SizedBox`: Memberikan space diantara widget
  + `ListView`: Digunakan untuk loop item

## Jelaskan bagaimana cara kamu mengimplementasikan checklist di atas secara step-by-step! (bukan hanya sekadar mengikuti tutorial).

- [x] Memastikan deployment proyek tugas Django kamu telah berjalan dengan baik. <br>
  + Mencoba redeploy dan bertanya ke kakak asdos jika mengalami kerusakan
- [x] Membuat halaman login pada proyek tugas Flutter. <br>
  + Buat `django-app` bernama authentication
  + Menambahkan `authentication` ke `INSTALLED APPS` pada `settings.py`
  + Menjalankan `pip install django-cors-headers`
  + Menambahkan `corsheaders` ke `INSTALLED APPS` pada `settings.py`
  + Menambahkan `corsheaders.middleware.CorsMiddleware` pada `settings.py`
  + Menambahkan variabel dibawah ini pada `settings.py`:
  ```
  CORS_ALLOW_ALL_ORIGINS = True
  CORS_ALLOW_CREDENTIALS = True
  CSRF_COOKIE_SECURE = True
  SESSION_COOKIE_SECURE = True
  CSRF_COOKIE_SAMESITE = 'None'
  SESSION_COOKIE_SAMESITE = 'None'
  ```
  + Membuat methode view untuk login pada berkas `authentication/views.py`:
  ```
  from django.shortcuts import render
  from django.contrib.auth import authenticate, login as auth_login
  from django.http import JsonResponse
  from django.views.decorators.csrf import csrf_exempt

  @csrf_exempt
  def login(request):
      username = request.POST['username']
      password = request.POST['password']
      user = authenticate(username=username, password=password)
      if user is not None:
          if user.is_active:
              auth_login(request, user)
              # Status login sukses.
              return JsonResponse({
                  "username": user.username,
                  "status": True,
                  "message": "Login sukses!"
                  # Tambahkan data lainnya jika ingin mengirim data ke Flutter.
              }, status=200)
          else:
              return JsonResponse({
                  "status": False,
                  "message": "Login gagal, akun dinonaktifkan."
              }, status=401)

      else:
          return JsonResponse({
              "status": False,
              "message": "Login gagal, periksa kembali email atau kata sandi."
          }, status=401)
  ```
  + Tambahkan kode berikut pada `urlpatterns` di `urls.py` aplikasi authentication:
  ```
  path('login/', login, name='login'),
  ``` 
  + Tambahkan kode berikut pada `urlpatterns` di `urls.py` pada berkas `minechesty/urls.py`:
  ```
  path('auth/', include('authentication.urls')),
  ```
  + Install beberapa package berikut:
  ```
  flutter pub add provider
  flutter pub add pbp_django_auth
  ```
  + Pada berkas `main.dart` ubahlah kode sebelumnya menjadi seperti ini untuk menyediakan `CookieRequest` library ke semua child widgets dengan menggunakan `provider`:
  ```
    class MyApp extends StatelessWidget {
      const MyApp({Key? key}) : super(key: key);

      @override
      Widget build(BuildContext context) {
          return Provider(
              create: (_) {
                  CookieRequest request = CookieRequest();
                  return request;
              },
              child: MaterialApp(
                  title: 'Flutter App',
                  theme: ThemeData(
                      colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
                      useMaterial3: true,
                  ),
                  home: MyHomePage()
              ),
          );
      }
  }
  ```
  + Buat berkas baru dengan nama `login.dart` pada folder `screens`
  + Isilah dengan kode dibawah ini
  ```
  import 'package:shopping_list/screens/menu.dart';
  import 'package:flutter/material.dart';
  import 'package:pbp_django_auth/pbp_django_auth.dart';
  import 'package:provider/provider.dart';

  void main() {
      runApp(const LoginApp());
  }

  class LoginApp extends StatelessWidget {
  const LoginApp({super.key});

  @override
  Widget build(BuildContext context) {
      return MaterialApp(
          title: 'Login',
          theme: ThemeData(
              primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
      );
      }
  }

  class LoginPage extends StatefulWidget {
      const LoginPage({super.key});

      @override
      _LoginPageState createState() => _LoginPageState();
  }

  class _LoginPageState extends State<LoginPage> {
      final TextEditingController _usernameController = TextEditingController();
      final TextEditingController _passwordController = TextEditingController();

      @override
      Widget build(BuildContext context) {
          final request = context.watch<CookieRequest>();
          return Scaffold(
              appBar: AppBar(
                  title: const Text('Login'),
              ),
              body: Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                          TextField(
                              controller: _usernameController,
                              decoration: const InputDecoration(
                                  labelText: 'Username',
                              ),
                          ),
                          const SizedBox(height: 12.0),
                          TextField(
                              controller: _passwordController,
                              decoration: const InputDecoration(
                                  labelText: 'Password',
                              ),
                              obscureText: true,
                          ),
                          const SizedBox(height: 24.0),
                          ElevatedButton(
                              onPressed: () async {
                                  String username = _usernameController.text;
                                  String password = _passwordController.text;

                                  // Cek kredensial
                                  // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
                                  // Untuk menyambungkan Android emulator dengan Django pada localhost,
                                  // gunakan URL http://10.0.2.2/
                                  final response = await request.login("http://<APP_URL_KAMU>/auth/login/", {
                                  'username': username,
                                  'password': password,
                                  });
                      
                                  if (request.loggedIn) {
                                      String message = response['message'];
                                      String uname = response['username'];
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(builder: (context) => MyHomePage()),
                                      );
                                      ScaffoldMessenger.of(context)
                                          ..hideCurrentSnackBar()
                                          ..showSnackBar(
                                              SnackBar(content: Text("$message Selamat datang, $uname.")));
                                      } else {
                                      showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                              title: const Text('Login Gagal'),
                                              content:
                                                  Text(response['message']),
                                              actions: [
                                                  TextButton(
                                                      child: const Text('OK'),
                                                      onPressed: () {
                                                          Navigator.pop(context);
                                                      },
                                                  ),
                                              ],
                                          ),
                                      );
                                  }
                              },
                              child: const Text('Login'),
                          ),
                      ],
                  ),
              ),
          );
      }
  }
  ```
  + Pada berkas `main.dart` ubah `home: MyHomePage()` menjadi `home: LoginPage()`
  
- [x] Mengintegrasikan sistem autentikasi Django dengan proyek tugas Flutter. <br>
  + Pada bagian login diatas sudah disertakan juga cara untuk autentikasi saat login.

- [x] Membuat model kustom sesuai dengan proyek aplikasi Django. <br>
  + Membuka endpoint JSON pada tugas sebelumnya
  + Lalu salin dan copy paste di website `quicktype`
  + Pada situs web Quicktype, ubahlah setup name menjadi Product, source type menjadi JSON, dan language menjadi Dart
  + Tempel data JSON yang telah disalin sebelumnya ke dalam textbox yang tersedia pada Quicktype.
  + Lalu click copy code dan salin pada berkas `models/item.dart`

- [x] Membuat halaman yang berisi daftar semua item yang terdapat pada endpoint JSON di Django yang telah kamu deploy. <br>
  - [x] Tampilkan name, amount, dan description dari masing-masing item pada halaman ini. <br>
    + Membuat berkas `list_product.dart` pada folder `lib/screens`
    + Pada file `list_item.dart` tambahkan kode berikut:
    ```
    import 'package:flutter/material.dart';
    import 'package:http/http.dart' as http;
    import 'dart:convert';
    import 'package:<APP_NAME>/models/product.dart';
    ```
    ```
    class ProductPage extends StatefulWidget {
      const ProductPage({Key? key}) : super(key: key);

      @override
      _ProductPageState createState() => _ProductPageState();
    }

    class _ProductPageState extends State<ProductPage> {
    Future<List<Item>> fetchProduct() async {
        var url = Uri.parse(
            'https://muhammad-rafli22-tugas.pbp.cs.ui.ac.id/get-item/');
        var response = await http.get(
            url,
            headers: {"Content-Type": "application/json"},
        );

        // melakukan decode response menjadi bentuk json
        var data = jsonDecode(utf8.decode(response.bodyBytes));

        // melakukan konversi data json menjadi object Product
        List<Item> list_product = [];
        for (var d in data) {
            if (d != null) {
                list_product.add(Item.fromJson(d));
            }
        }
        return list_product;
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
              appBar: AppBar(
                title: const Center(
                  child: Text(
                    'List Item',
                  ),
                ),
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
              ),
            drawer: const LeftDrawer(),
            body: FutureBuilder(
                future: fetchProduct(),
                builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.data == null) {
                        return const Center(child: CircularProgressIndicator());
                    } else {
                        if (!snapshot.hasData) {
                        return const Column(
                            children: [
                            Text(
                                "Tidak ada data Item.",
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
                                    child: InkWell(
                                      child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                          Text(
                                          "${index + 1}. ${snapshot.data![index].fields.name}",
                                          style: const TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                          ),
                                          ),
                                          const SizedBox(height: 10),
                                          Text("${snapshot.data![index].fields.amount}"),
                                          const SizedBox(height: 10),
                                          Text("${snapshot.data![index].fields.description}"),
                                          const SizedBox(height: 10),
                                          Text("${snapshot.data![index].fields.rarity}"),
                                            ElevatedButton(
                                              onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => DetailItemPage(item: snapshot.data![index]),
                                                ),
                                              );
                                          },
                                          child: const Text('Detail Item'),
                                        ),
                                      ],
                                      ),
                                    )
                                ));
                        }
                    }
                }));
        }
    }
    ```
- [x] Membuat halaman detail untuk setiap item yang terdapat pada halaman daftar Item. <br>
  - [x] Halaman ini dapat diakses dengan menekan salah satu item pada halaman daftar Item. <br>
    + Pada berkas `list_item.dart` tambahkan kode berikut untuk membuat button ke setiap detail item:
    ```
          ElevatedButton(
        onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailItemPage(item: snapshot.data![index]),
          ),
        );
      },
      child: const Text('Detail Item'),
    ),
    ```
  - [x] Tampilkan seluruh atribut pada model item kamu pada halaman ini. <br>
  - [x] Tambahkan tombol untuk kembali ke halaman daftar item. <br>
  + Untuk menambahkan atribut model dan tombol, buatlah berkas `detail_item.dart` lalu tambahkan kode berikut ini:
  ```
  import 'package:flutter/material.dart';
  import 'package:minechesty/models/item.dart';
  import 'package:minechesty/widgets/left_drawer.dart';

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
                'Description: ${widget.item.fields.description}',
                style: const TextStyle(fontSize: 18),
              ),
              Text(
                'Rarity: ${widget.item.fields.rarity}',
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
  ```

# Tugas 8

## Jelaskan perbedaan antara Navigator.push() dan Navigator.pushReplacement(), disertai dengan contoh mengenai penggunaan kedua metode tersebut yang tepat!

Method `push()` menambahkan suatu route ke dalam stack route yang dikelola oleh Navigator. Method ini menyebabkan route yang ditambahkan berada pada paling atas stack, sehingga route yang baru saja ditambahkan tersebut akan muncul dan ditampilkan kepada pengguna. Contoh `push()`: <br>

```
Navigator.push(
 context,
 MaterialPageRoute(builder: (context) => SecondRoute()),
);
``` 

Method `pushReplacement()` menghapus route yang sedang ditampilkan kepada pengguna dan menggantinya dengan suatu route. Method ini menyebabkan aplikasi untuk berpindah dari route yang sedang ditampilkan kepada pengguna ke suatu route yang diberikan. Pada stack route yang dikelola Navigator, route lama pada atas stack akan digantikan secara langsung oleh route baru yang diberikan tanpa mengubah kondisi elemen stack yang berada di bawahnya.

```
Navigator.pushReplacement(
 context,
 MaterialPageRoute(builder: (context) => SecondRoute()),
);
```

Walaupun `push()` dan `pushReplacement()` sekilas terlihat mirip, namun perbedaan kedua method tersebut terletak pada apa yang dilakukan kepada route yang berada pada atas stack. `push()` akan menambahkan route baru diatas route yang sudah ada pada atas stack, sedangkan `pushReplacement()` menggantikan route yang sudah ada pada atas stack dengan route baru tersebut. Penting juga untuk memperhatikan kemungkinan urutan dan isi dari stack, karena jika kondisi stack kosong serta kita menekan tombol Back pada gawai, maka sistem akan keluar dari aplikasi tersebut.

## Jelaskan masing-masing layout widget pada Flutter dan konteks penggunaannya masing-masing!

+ Row dan Column

Deskripsi: `Row` dan `Column` adalah widget yang mengatur anak-anaknya dalam satu baris atau kolom. Row mengatur anak-anaknya secara horizontal, sementara Column mengatur anak-anaknya secara vertikal. <br>

```
Container(
  width: 100.0,
  height: 100.0,
  color: Colors.blue,
  child: // child widget goes here
)

```

+ Container

Deskripsi: `Container` adalah widget dasar untuk mengatur tata letak dan dekorasi. Ini dapat digunakan untuk menentukan ukuran, padding, warna latar belakang, dan banyak properti lainnya. <br>

```
Container(
  width: 100.0,
  height: 100.0,
  color: Colors.blue,
  child: // child widget goes here
)
```

+ ListView

Deskripsi: `ListView` adalah widget untuk menangani daftar item yang dapat di-scroll. Ini memungkinkan membuat daftar dengan elemen-elemen yang bisa di-scroll secara vertikal atau horizontal. <br>

```
ListView(
  children: <Widget>[
    // list items go here
  ],
)
```

+ Stack

Deskripsi: `Stack` memungkinkan menumpuk widget di atas satu sama lain. Widget dalam `Stack` dapat menumpuk satu di atas yang lain atau menempati posisi tertentu di dalamnya. <br>

```
Stack(
  children: <Widget>[
    // stacked widgets go here
  ],
)
```

+ Expanded dan Flexible

Deskripsi: `Expanded` dan `Flexible` digunakan untuk mengatur bagaimana widget berskala dalam tata letak flex. Mereka membantu dalam pengaturan ruang dan ukuran dalam tata letak flex. <br>

```
Row(
  children: <Widget>[
    Expanded(
      child: // widget 1
    ),
    Flexible(
      child: // widget 2
    ),
  ],
)
```

## Sebutkan apa saja elemen input pada form yang kamu pakai pada tugas kali ini dan jelaskan mengapa kamu menggunakan elemen input tersebut!
 
TextFormField untuk Nama Item <br>

```
TextFormField(
  decoration: InputDecoration(
    hintText: "Nama Item",
    labelText: "Nama Item",
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.0),
    ),
  ),
  onChanged: (String? value) {
    setState(() {
      _name = value!;
    });
  },
  validator: (String? value) {
    if (value == null || value.isEmpty) {
      return "Nama tidak boleh kosong!";
    }
    return null;
  },
)
```

Penjelasan: Elemen input ini digunakan untuk mengumpulkan nama item. `onChanged` digunakan untuk menyimpan nilai yang diinput ke dalam variabel `_name`, sedangkan `validator` digunakan untuk memastikan bahwa input tidak kosong.

TextFormField untuk Jumlah <br>

```
TextFormField(
  decoration: InputDecoration(
    hintText: "Jumlah",
    labelText: "Jumlah",
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.0),
    ),
  ),
  onChanged: (String? value) {
    setState(() {
      _amount = int.parse(value!);
    });
  },
  validator: (String? value) {
    if (value == null || value.isEmpty) {
      return "Jumlah tidak boleh kosong!";
    }
    if (int.tryParse(value) == null) {
      return "Jumlah harus berupa angka!";
    }
    return null;
  },
)
```

Penjelasan: Elemen input ini digunakan untuk mengumpulkan jumlah item. `onChanged` digunakan untuk menyimpan nilai yang diinput ke dalam variabel `_amount`, dan `validator` digunakan untuk memastikan bahwa input tidak kosong dan merupakan angka. <br>

TextFormField untuk Deskripsi

```
TextFormField(
  decoration: InputDecoration(
    hintText: "Deskripsi",
    labelText: "Deskripsi",
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.0),
    ),
  ),
  onChanged: (String? value) {
    setState(() {
      _description = value!;
    });
  },
  validator: (String? value) {
    if (value == null || value.isEmpty) {
      return "Deskripsi tidak boleh kosong!";
    }
    return null;
  },
)
```

Penjelasan: Elemen input ini digunakan untuk mengumpulkan deskripsi item. `onChanged` digunakan untuk menyimpan nilai yang diinput ke dalam variabel `_description`, dan `validator` digunakan untuk memastikan bahwa input tidak kosong. <br>

TextFormField untuk Rarity

```
TextFormField(
  decoration: InputDecoration(
    hintText: "Rarity",
    labelText: "Rarity",
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.0),
    ),
  ),
  onChanged: (String? value) {
    setState(() {
      _rarity = value!;
    });
  },
  validator: (String? value) {
    if (value == null || value.isEmpty) {
      return "Rarity tidak boleh kosong!";
    }
    return null;
  },
)
```

Penjelasan: Elemen input ini digunakan untuk mengumpulkan tingkat rarity item. `onChanged` digunakan untuk menyimpan nilai yang diinput ke dalam variabel `_rarity`, dan `validator` digunakan untuk memastikan bahwa input tidak kosong. <br>

Pemilihan elemen input sesuai dengan jenis informasi yang perlu dikumpulkan dari pengguna (nama item, jumlah, deskripsi, dan rarity), dan validasi dilakukan untuk memastikan bahwa data yang dimasukkan sesuai dengan yang diharapkan. <br>

## Bagaimana penerapan clean architecture pada aplikasi Flutter?
Penerapan clean architecture pada aplikasi Flutter merupakan prinsip seperti Separation of Concern pada MVP, MVT, atau MVCC. <br>
Pembagiannya sebagai berikut: <br>

+ Domain
  + Entities
  + Usecases
  + Repositories

+ App
  + View
  + Controller
  + Presenter
  + Extra

+ Data
  + Repositories
  + Models
  + Mappers
  + Extra

+ Device
  + Devices
  + Extra

## Jelaskan bagaimana cara kamu mengimplementasikan checklist di atas secara step-by-step! (bukan hanya sekadar mengikuti tutorial)

- [x] Membuat minimal satu halaman baru pada aplikasi, yaitu halaman formulir tambah item baru dengan ketentuan sebagai berikut: <br>
  + Pada folder `lib` buatlah file dengan nama `itemlist_form.dart`.
  - [x] Memakai minimal tiga elemen input, yaitu name, amount, description. Tambahkan elemen input sesuai dengan model pada aplikasi tugas Django yang telah kamu buat. <br>
    + Pada file tersebut tambahkan kode dibawah ini
    ```
    import 'package:flutter/material.dart';
    import 'package:minechesty/widgets/left_drawer.dart';

    class InventoryFormPage extends StatefulWidget {
        const InventoryFormPage({super.key});

        @override
        State<InventoryFormPage> createState() => _InventoryFormPageState();
    }

    class _InventoryFormPageState extends State<InventoryFormPage> {
        final _formKey = GlobalKey<FormState>();
        String _name = "";
        int _amount = 0;
        String _description = "";
        String _rarity = "";

        @override
        Widget build(BuildContext context) {
            return Scaffold(
              appBar: AppBar(
                title: const Center(
                  child: Text(
                    'Form Tambah Item',
                  ),
                ),
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
              ),
              drawer: const LeftDrawer(),
              body: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: "Nama Item",
                            labelText: "Nama Item",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          onChanged: (String? value) {
                            setState(() {
                              _name = value!;
                            });
                          },
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Nama tidak boleh kosong!";
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: "Jumlah",
                            labelText: "Jumlah",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          onChanged: (String? value) {
                            setState(() {
                              _amount = int.parse(value!);
                            });
                          },
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Jumlah tidak boleh kosong!";
                            }
                            if (int.tryParse(value) == null) {
                              return "Jumlah harus berupa angka!";
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: "Deskripsi",
                            labelText: "Deskripsi",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          onChanged: (String? value) {
                            setState(() {
                              _description = value!;
                            });
                          },
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Deskripsi tidak boleh kosong!";
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: "Deskripsi",
                            labelText: "Deskripsi",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          onChanged: (String? value) {
                            setState(() {
                              _rarity = value!;
                            });
                          },
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Rarity tidak boleh kosong!";
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  )
                ),
              ),
            );
        }
    }
    ```
  - [x] Memiliki sebuah tombol Save. <br>
    + Lalu buatlah sebuah child dari `Column`. Bungkus tombol ke widget `Padding` dan `Align`. Berikut kodenya: 

    ```
      Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(Colors.indigo),
          ),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Item berhasil tersimpan'),
                    content: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text('Nama: $_name'),
                          Text('Jumlah: $_amount'),
                          Text('Deskripsi: $_description'),
                          Text('Rarity: $_rarity'),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                        child: const Text('OK'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  );
                },
              );
            _formKey.currentState!.reset();
            }
          },
          child: const Text(
            "Save",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    ),
    ```

  - [x] Setiap elemen input di formulir juga harus divalidasi dengan ketentuan sebagai berikut: <br>
    - [x] Setiap elemen input tidak boleh kosong. <br>
    - [x] Setiap elemen input harus berisi data dengan tipe data atribut modelnya. <br>

      + Setiap meminta input `String` pada form saya membuat validator seperti kode berikut:
      ```
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return "Nama tidak boleh kosong!";
        }
        return null;
      },
      ```

      + Setiap meminta input `integer` pada form saya membuat validator seperti kode berikut:

      ```
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return "Jumlah tidak boleh kosong!";
        }
        if (int.tryParse(value) == null) {
          return "Jumlah harus berupa angka!";
        }
        return null;
      },
      ```

- [x] Mengarahkan pengguna ke halaman form tambah item baru ketika menekan tombol Tambah Item pada halaman utama. <br>
  + Pada card yang terdapat pada halaman utama saya menambahkan Navigator untuk push page InventoryFormPage ke stack. Berikut kodenya: 
  ```
    if (item.name == "Tambah Item") {
    Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const InventoryFormPage(),
    ));
  }
  ```

- [x] Memunculkan data sesuai isi dari formulir yang diisi dalam sebuah pop-up setelah menekan tombol Save pada halaman formulir tambah item baru. <br>
  + Tambahkan fungsi `showDialog()` pada bagian `onPressed()` dan munculkan widget `AlertDialog` pada fungsi tersebut. Pada widget tambahkan child berupa widget `Column` yang berisi children dengan widget `Text` untuk menampilkan data-data yang sesuai. Kemudian, tambahkan juga fungsi untuk reset form. Berikut kodenya: 

  ```
    onPressed: () {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Item berhasil tersimpan'),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text('Nama: $_name'),
                  Text('Jumlah: $_amount'),
                  Text('Deskripsi: $_description'),
                  Text('Rarity: $_rarity'),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    _formKey.currentState!.reset();
    }
  },
  ```

- [x] Membuat sebuah drawer pada aplikasi dengan ketentuan sebagai berikut: <br>
  + Pada folder `lib` buatlah folder `widgets` yang bernama `left_drawer.dart`. Lalu tambahkan kode berikut:
  ```
  import 'package:flutter/material.dart';
  import 'package:minechesty/screens/itemlist_form.dart';
  import 'package:minechesty/screens/menu.dart';


  class LeftDrawer extends StatelessWidget {
    const LeftDrawer({super.key});

    @override
    Widget build(BuildContext context) {
      return Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.indigo,
              ),
              child: Column(
                children: [
                  Text(
                    'Minechesty',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(10)),
                  Text("Catat seluruh keperluan di sini!",
                          style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.normal,
                          color: Colors.white
                        ),
                      ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text('Halaman Utama'),
              // Bagian redirection ke MyHomePage
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyHomePage(),
                    ));
              },
            ),
            ListTile(
              leading: const Icon(Icons.add_shopping_cart),
              title: const Text('Tambah Item'),
              // Bagian redirection ke ItemFormPage
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const InventoryFormPage(),
                    ));
              },
            ),
          ],
        ),
      );
    }
  }
  ```
  - [x] Drawer minimal memiliki dua buah opsi, yaitu Halaman Utama dan Tambah Item. <br>
    + Saya menambahkan ListView berisi ListTile yang dimana disini akan digunakan untuk menampilkan secara berurut opsi untuk ke Halaman Utama dan Tambah Item. Berikut kodenya di dalam ListView:
    ```
      ListTile(
      leading: const Icon(Icons.home_outlined),
      title: const Text('Halaman Utama'),
      // Bagian redirection ke MyHomePage
      onTap: () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MyHomePage(),
            ));
      },
    ),
    ListTile(
      leading: const Icon(Icons.add_shopping_cart),
      title: const Text('Tambah Item'),
      // Bagian redirection ke ItemFormPage
      onTap: () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const InventoryFormPage(),
            ));
      },
    ),
    ```
  - [x] Ketika memiih opsi Halaman Utama, maka aplikasi akan mengarahkan pengguna ke halaman utama. <br>
    + Pada widget ListTile 'Halaman Utama' saya menambahkan Navigator.pushReplacement didalam fungsi onTap yang berarti saat ditekan akan menghapus route yang sedang ditampilkan kepada pengguna dan menggantinya dengan route ke Halaman Utama. Berikut kodenya:
    ```
    onTap: () {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MyHomePage(),
        ));
    },
    ```

  - [x] Ketika memiih opsi (Tambah Item), maka aplikasi akan mengarahkan pengguna ke halaman form tambah item baru. <br>
    + Pada widget ListTile 'Tambah Item' saya menambahkan Navigator.pushReplacement didalam fungsi onTap yang berarti saat ditekan akan menghapus route yang sedang ditampilkan kepada pengguna dan menggantinya dengan route ke form tambah item baru. Berikut kodenya:
    ```
    onTap: () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const InventoryFormPage(),
          ));
    },
    ```

# Tugas 7 PBP

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
