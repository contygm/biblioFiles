import 'package:flutter/material.dart';
import '../components/book_grid.dart';
import '../components/floating_back_button.dart';
import '../models/book.dart';
import '../models/bookLibrary.dart';
import '../db/databaseops.dart';
import '../templates/default_template.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ShelvesScreen extends StatefulWidget {
  static const routeName = 'shelvesScreen';

  @override
  _ShelvesScreenState createState() => _ShelvesScreenState();
}

class _ShelvesScreenState extends State<ShelvesScreen> {
  List<String> shelves = ['Currently Reading','Checked Out'];

  @override
  void initState() {
    super.initState();
    getBooksinShelves();
  }

  List<dynamic> checkedOutBooks = [];
  List<dynamic> currentBooks = [];
  List<List<dynamic>> allBooks = [];
  void getBooksinShelves() async {
    final auth = FirebaseAuth.instance;
    final user = await auth.currentUser();
    final uid = user.uid;
    var coBooks = await callGetCheckedOutBooks(uid);
    var curBooks = await callGetReadingBooks(uid);
    setState(() {
      checkedOutBooks = coBooks;
      currentBooks = curBooks;

      allBooks.add(checkedOutBooks);
      allBooks.add(currentBooks);
    });
  }

  Widget build(BuildContext context) {
    return DefaultTemplate(
        floatingAction: FloatingBackButton(context),
        content: shelvesList(context));
  }

  Widget shelvesList(BuildContext context) {
    return ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: shelves.length,
        itemBuilder: (context, index) {
          return Container(
            height: 300,
            child: BookGrid(
                bookLibrary: allBooks[index],
                crossAxisCount: 2,
                title: shelves[index],
                bookCount: allBooks[index].length,
                scrollDirection: Axis.horizontal),
          );
        },
        separatorBuilder: (context, index) => const Divider());
  }
}
