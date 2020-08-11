import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/book_grid.dart';
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
      
      if (currentBooks.isEmpty) {
        shelves.remove('Currently Reading');
      } else {
        allBooks.add(currentBooks);
      }

      if (checkedOutBooks.isEmpty) {
        shelves.remove('Checked Out');
      } else {
        allBooks.add(checkedOutBooks);
      }
    });
  }

  Widget build(BuildContext context) {
    return DefaultTemplate(
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
          itemCount: shelves.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
              child: Container(
                height: 250,
                child: BookGrid(
                  bookLibrary: allBooks[index],
                  crossAxisCount: 1,
                  title: shelves[index],
                  bookCount: allBooks[index].length,
                  scrollDirection: Axis.horizontal),
              ),
            );
          },
          separatorBuilder: (context, index) => const Divider());
      }
    }
  }
}
