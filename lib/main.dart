import 'package:flutter/material.dart';
import 'package:local_json1/book_model.dart';
import 'package:local_json1/book_services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: BookPage(),
    );
  }
}

class BookPage extends StatefulWidget {
  @override
  _BookPageState createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Halaman Buku'),
      ),
      body: FutureBuilder<List<BookModel>>(
          future: BookServices.getBooksFromJSON(),
          builder: (context, snapshoot) {
            if (snapshoot.connectionState == ConnectionState.done) {
              return ListView.builder(
                  itemCount: snapshoot.data!.length,
                  itemBuilder: (context, index) {
                    final book = snapshoot.data![index];
                    return ListTile(
                      title: Text(book.judul),
                      subtitle: Text(
                        'Jumlah halaman ${book.judul}',
                      ),
                      trailing: book.isBestSeller
                          ? Chip(
                              label: Text(
                                'Best Seller',
                                style: Theme.of(context)
                                    .textTheme
                                    .button!
                                    .copyWith(
                                      color: Colors.white,
                                    ),
                              ),
                              backgroundColor: Colors.blue)
                          : SizedBox.shrink(),
                    );
                  });
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
