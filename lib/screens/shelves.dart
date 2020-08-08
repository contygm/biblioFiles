import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/book_grid.dart';
import '../components/floating_back_button.dart';
import '../db/databaseops.dart';
import '../templates/default_template.dart';

class ShelvesScreen extends StatefulWidget {
  static const routeName = 'shelvesScreen';

  @override
  _ShelvesScreenState createState() => _ShelvesScreenState();
}

class _ShelvesScreenState extends State<ShelvesScreen> {
  List<String> shelves = ['Currently Reading', 'Checked Out'];

  @override
  void initState() {
    super.initState();
    getBooksinShelves();
  }

  List<dynamic> checkedOutBooks = [];
  List<dynamic> currentBooks = [];
  List<List<dynamic>> allBooks = [];
  bool booksAsked = false;
  void getBooksinShelves() async {
    final auth = FirebaseAuth.instance;
    final user = await auth.currentUser();
    final uid = user.uid;
    var coBooks = await callGetCheckedOutBooks(uid);
    var curBooks = await callGetReadingBooks(uid);
    setState(() {
      booksAsked = true;
      checkedOutBooks = coBooks;
      currentBooks = curBooks;
      if (checkedOutBooks.isEmpty) {
        shelves.remove('Checked Out');
      } else {
        allBooks.add(checkedOutBooks);
      }
      if (currentBooks.isEmpty) {
        shelves.remove('Currently Reading');
      } else {
        allBooks.add(currentBooks);
      }
    });
  }

  Widget build(BuildContext context) {
    return DefaultTemplate(
        floatingAction: FloatingBackButton(context),
        content: shelvesList(context));
  }

  Widget shelvesList(BuildContext context) {
    if (booksAsked == false) {
      return Container(child: CircularProgressIndicator());
    } else {
      if (allBooks.isEmpty) {
        return Text('All of your shelves are empty!',
            style: TextStyle(fontSize: 35), textAlign: TextAlign.center);
      } else {
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
  }
}
